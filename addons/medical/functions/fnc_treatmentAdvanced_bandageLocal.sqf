/*
 * Author: Glowbal
 * Handles the bandage of a patient.
 *
 * Arguments:
 * 0: The patient <OBJECT>
 * 1: Treatment classname <STRING>
 *
 *
 * Return Value:
 * Succesful treatment started <BOOL>
 *
 * Public: No
 */

#include "script_component.hpp"

private ["_openWounds", "_config", "_effectiveness","_mostEffectiveInjury", "_mostEffectiveSpot", "_woundEffectivenss", "_mostEffectiveInjury", "_impact", "_exit", "_classID", "_effectivenessFound", "_className", "_hitPoints", "_hitSelections", "_point", "_woundTreatmentConfig"];
params ["_target", "_bandage", "_selectionName", ["_specificClass", -1]];

// Ensure it is a valid bodypart
_part = [_selectionName] call FUNC(selectionNameToNumber);
if (_part < 0) exitWith {false};

// Get the open wounds for this unit
_openWounds = _target getVariable [QGVAR(openWounds), []];
if (count _openWounds == 0) exitWith {false}; // nothing to do here!

// Get the default effectiveness for the used bandage
_config = (ConfigFile >> "ACE_Medical_Advanced" >> "Treatment" >> "Bandaging");
_effectiveness = getNumber (_config >> "effectiveness");
if (isClass (_config >> _bandage)) then {
    _config = (_config >> _bandage);
    if (isNumber (_config >> "effectiveness")) then { _effectiveness = getNumber (_config >> "effectiveness");};
};

// Figure out which injury for this bodypart is the best choice to bandage
_mostEffectiveSpot = 0;
_effectivenessFound = -1;
_mostEffectiveInjury = _openWounds select 0;
_exit = false;
{
    _x params ["", "_classID", "_partX"];
    TRACE_2("OPENWOUND: ", _target, _x);
    // Only parse injuries that are for the selected bodypart.
    if (_partX == _part) then {
        _woundEffectivenss = _effectiveness;

        // Select the classname from the wound classname storage
        _className = GVAR(woundClassNames) select _classID;

        // Check if this wound type has attributes specified for the used bandage
        if (isClass (_config >> _className)) then {
            // Collect the effectiveness from the used bandage for this wound type
            _woundTreatmentConfig = (_config >> _className);
            if (isNumber (_woundTreatmentConfig >> "effectiveness")) then {
                _woundEffectivenss = getNumber (_woundTreatmentConfig >> "effectiveness");
            };
        } else {
            ACE_LOGWARNING_2("No config for wound type [%1] config base [%2]", _className, _config);
        };

        TRACE_2("Wound classes: ", _specificClass, _classID);
        if (_specificClass == _classID) exitWith {
            _effectivenessFound = _woundEffectivenss;
            _mostEffectiveSpot = _forEachIndex;
            _mostEffectiveInjury = _x;
            _exit = true;
        };

        // Check if this is the currently most effective found.
        if (_woundEffectivenss * ((_x select 4) * (_x select 3)) > _effectivenessFound * ((_mostEffectiveInjury select 4) * (_mostEffectiveInjury select 3))) then {
            _effectivenessFound = _woundEffectivenss;
            _mostEffectiveSpot = _forEachIndex;
            _mostEffectiveInjury = _x;
        };
    };
    if (_exit) exitWith {};
} forEach _openWounds;

if (_effectivenessFound == -1) exitWith {}; // Seems everything is patched up on this body part already..


// TODO refactor this part
// Find the impact this bandage has and reduce the amount this injury is present
_impact = if ((_mostEffectiveInjury select 3) >= _effectivenessFound) then {_effectivenessFound} else { (_mostEffectiveInjury select 3) };
_mostEffectiveInjury set [ 3, ((_mostEffectiveInjury select 3) - _impact) max 0];
_openWounds set [_mostEffectiveSpot, _mostEffectiveInjury];

_target setVariable [QGVAR(openWounds), _openWounds, !USE_WOUND_EVENT_SYNC];

if (USE_WOUND_EVENT_SYNC) then {
    ["medical_propagateWound", [_target, _mostEffectiveInjury]] call EFUNC(common,globalEvent);
};
// Handle the reopening of bandaged wounds
if (_impact > 0 && {GVAR(enableAdvancedWounds)}) then {
    [_target, _impact, _part, _mostEffectiveSpot, _mostEffectiveInjury, _bandage] call FUNC(handleBandageOpening);
};

// If all wounds to a body part have been bandaged, reset damage to that body part to zero
// so that the body part functions normally and blood is removed from the uniform.
// Arma combines left and right arms into a single body part (HitHands), same with left and right legs (HitLegs).
// Arms are actually hands.
if (GVAR(healHitPointAfterAdvBandage)) then {
    private["_currentWounds", "_headWounds", "_bodyWounds", "_legsWounds", "_armWounds"];

    // Get the list of the wounds the target is currently suffering from.
    _currentWounds = _target getVariable [QGVAR(openWounds), []];

    // Tally of unbandaged wounds to each body part.
    _headWounds = 0;
    _bodyWounds = 0;
    _legsWounds = 0;
    _armWounds  = 0;

    // Loop through all current wounds and add up the number of unbandaged wounds on each body part.
    {
        _x params ["", "", "_bodyPart", "_numOpenWounds", "_bloodLoss"];

        // Use switch/case for early termination if wounded limb is found before all six are checked.
        // Number of wounds multiplied by blood loss will return zero for a fully
        // bandaged body part, not incrementing the wound counter; or it will return
        // some other number which will increment the wound counter. 
        switch (_bodyPart) do {
            // Head
            case 0: {
                _headWounds = _headWounds + (_numOpenWounds * _bloodLoss);
            };

            // Body
            case 1: {
                _bodyWounds = _bodyWounds + (_numOpenWounds * _bloodLoss);
            };

            // Left Arm
            case 2: {
                _armWounds = _armWounds + (_numOpenWounds * _bloodLoss);
            };

            // Right Arm
            case 3: {
                _armWounds = _armWounds + (_numOpenWounds * _bloodLoss);
            };

            // Left Leg
            case 4: {
                _legsWounds = _legsWounds + (_numOpenWounds * _bloodLoss);
            };

            // Right Leg
            case 5: {
                _legsWounds = _legsWounds + (_numOpenWounds * _bloodLoss);
            };
        };
    } forEach _currentWounds;

    // Any body part that has no wounds is healed to full health
    if (_headWounds == 0) then {
        _target setHitPointDamage ["hitHead",  0.0];
    };

    if (_bodyWounds == 0) then {
        _target setHitPointDamage ["hitBody",  0.0];
    };

    if (_armWounds == 0) then {
        _target setHitPointDamage ["hitHands", 0.0];
    };

    if (_legsWounds == 0) then {
        _target setHitPointDamage ["hitLegs",  0.0];
    };
};

true;
