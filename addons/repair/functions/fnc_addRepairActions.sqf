/*
 * Author: commy2, SilentSpike
 * Checks if the vehicles class already has the actions initialized, otherwise add all available repair options. Calleed from init EH.
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [vehicle] call ace_repair_fnc_addRepairActions
 *
 * Public: No
 */
#include "script_component.hpp"

if (!hasInterface) exitWith {};

params ["_vehicle"];
TRACE_2("params", _vehicle,typeOf _vehicle);

private["_action", "_childHitPoint", "_condition", "_groupsConfig", "_hitPoint", "_hitPointsAddedAmount", "_hitPointsAddedNames", "_hitPointsAddedStrings", "_icon", "_initializedClasses", "_name", "_position", "_positionsConfig", "_processedHitPoints", "_selection", "_statement", "_target", "_type"];

_type = typeOf _vehicle;

_initializedClasses = GETMVAR(GVAR(initializedClasses),[]);

// do nothing if the class is already initialized
if (_type in _initializedClasses) exitWith {};

// get all hitpoints and selections
(getAllHitPointsDamage _vehicle) params [["_hitPoints", []], ["_hitSelections", []]];

// get hitpoints of wheels with their selections
([_vehicle] call FUNC(getWheelHitPointsWithSelections)) params ["_wheelHitPoints", "_wheelHitSelections"];

_hitPointsAddedNames = [];
_hitPointsAddedStrings = [];
_hitPointsAddedAmount = [];
_processedHitpoints = [];

{
    _selection = _x;
    _hitpoint = _hitPoints select _forEachIndex;

    if (_selection in _wheelHitSelections) then {
        // Wheels should always be unique
        if (_hitpoint in _processedHitpoints) exitWith {TRACE_3("Duplicate Wheel",_hitpoint,_forEachIndex,_selection);};

        _icon = "A3\ui_f\data\igui\cfg\actions\repair_ca.paa";

        _position = compile format ["_target selectionPosition ['%1', 'HitPoints'];", _selection];

        TRACE_3("Adding Wheel Actions",_hitpoint,_forEachIndex,_selection);

        // An action to remove the wheel is required
        _name = format ["Remove_%1_%2", _forEachIndex, _hitpoint];
        _text = localize LSTRING(RemoveWheel);
        _condition = {[_this select 1, _this select 0, _this select 2 select 0, "RemoveWheel"] call DFUNC(canRepair)};
        _statement = {[_this select 1, _this select 0, _this select 2 select 0, "RemoveWheel"] call DFUNC(repair)};
        _action = [_name, _text, _icon, _statement, _condition, {}, [_hitpoint], _position, 2] call EFUNC(interact_menu,createAction);
        [_type, 0, [], _action] call EFUNC(interact_menu,addActionToClass);

        // An action to replace the wheel is required
        _name = format ["Replace_%1_%2", _forEachIndex, _hitpoint];
        _text = localize LSTRING(ReplaceWheel);
        _condition = {[_this select 1, _this select 0, _this select 2 select 0, "ReplaceWheel"] call DFUNC(canRepair)};
        _statement = {[_this select 1, _this select 0, _this select 2 select 0, "ReplaceWheel"] call DFUNC(repair)};
        _action = [_name, _text, _icon, _statement, _condition, {}, [_hitpoint], _position, 2] call EFUNC(interact_menu,createAction);
        [_type, 0, [], _action] call EFUNC(interact_menu,addActionToClass);
    } else {
        //Skip glass hitpoints
        if (((toLower _hitPoint) find "glass") != -1) exitWith {
            TRACE_3("Skipping Glass",_hitpoint,_forEachIndex,_selection);
        };
        // Empty selections don't exist
        // Empty hitpoints don't contain enough information
        if (_selection isEqualTo "") exitWith { TRACE_3("Selection Empty",_hitpoint,_forEachIndex,_selection); };
        if (_hitpoint isEqualTo "") exitWith { TRACE_3("Hitpoint Empty",_hitpoint,_forEachIndex,_selection); };
        //Depends hitpoints shouldn't be modified directly (will be normalized)
        if (isText (configFile >> "CfgVehicles" >> _type >> "HitPoints" >> _hitpoint >> "depends")) exitWith {
            TRACE_3("Skip Depends",_hitpoint,_forEachIndex,_selection);
        };

        // Associated hitpoints can be grouped via config to produce a single repair action
        _groupsConfig = configFile >> "CfgVehicles" >> _type >> QGVAR(hitpointGroups);
        _childHitPoint = false;
        if (isArray _groupsConfig) then {
            {
                {
                    if (_hitpoint == _x) exitWith {
                        _childHitPoint = true;
                    };
                } forEach (_x select 1);
            } forEach (getArray _groupsConfig);
        };
        // If the current selection is associated with a child hitpoint, then skip
        if (_childHitPoint) exitWith { TRACE_3("childHitpoint",_hitpoint,_forEachIndex,_selection); };

        // Find the action position
        _position = compile format ["_target selectionPosition ['%1', 'HitPoints'];", _selection];

        // Custom position can be defined via config for associated hitpoint
        _positionsConfig = configFile >> "CfgVehicles" >> _type >> QGVAR(hitpointPositions);
        if (isArray _positionsConfig) then {
            {
                _x params ["_hit", "_pos"];
                if (_hitpoint == _hit) exitWith {
                    if (_pos isEqualType []) exitWith {
                        _position = _pos; // Position in model space
                    };
                    if (_pos isEqualType "") exitWith {
                        _position = compile format ["_target selectionPosition ['%1', 'HitPoints'];", _pos];
                    };
                    ACE_LOGERROR_3("Invalid custom position %1 of hitpoint %2 in vehicle %3.",_position,_hitpoint,_type);
                };
            } forEach (getArray _positionsConfig);
        };

        // Prepair the repair action
        _name = format ["Repair_%1_%2", _forEachIndex, _selection];
        _icon = "A3\ui_f\data\igui\cfg\actions\repair_ca.paa";

        // Find localized string and track those added for numerization
        ([_hitpoint, "%1", _hitpoint, [_hitPointsAddedNames, _hitPointsAddedStrings, _hitPointsAddedAmount]] call FUNC(getHitPointString)) params ["_text", "_trackArray"];
        _hitPointsAddedNames = _trackArray select 0;
        _hitPointsAddedStrings = _trackArray select 1;
        _hitPointsAddedAmount = _trackArray select 2;

        if (_hitpoint in TRACK_HITPOINTS) then {
            // Tracks should always be unique
            if (_hitpoint in _processedHitpoints) exitWith {TRACE_3("Duplicate Track",_hitpoint,_forEachIndex,_selection);};
            if (_hitpoint == "HitLTrack") then {
                _position = [-1.75, 0, -1.75];
            } else {
                _position = [1.75, 0, -1.75];
            };
            TRACE_4("Adding RepairTrack",_hitpoint,_forEachIndex,_selection,_text);
            _condition = {[_this select 1, _this select 0, _this select 2 select 0, "RepairTrack"] call DFUNC(canRepair)};
            _statement = {[_this select 1, _this select 0, _this select 2 select 0, "RepairTrack"] call DFUNC(repair)};
            _action = [_name, _text, _icon, _statement, _condition, {}, [_hitpoint], _position, 4] call EFUNC(interact_menu,createAction);
            [_type, 0, [], _action] call EFUNC(interact_menu,addActionToClass);
        } else {
            TRACE_4("Adding MiscRepair",_hitpoint,_forEachIndex,_selection,_text);
            _condition = {[_this select 1, _this select 0, _this select 2 select 0, "MiscRepair"] call DFUNC(canRepair)};
            _statement = {[_this select 1, _this select 0, _this select 2 select 0, "MiscRepair"] call DFUNC(repair)};
            _action = [_name, _text, _icon, _statement, _condition, {}, [_forEachIndex], _position, 5] call EFUNC(interact_menu,createAction);
            // Put inside main actions if no other position was found above
            if (_position isEqualTo [0,0,0]) then {
                [_type, 0, ["ACE_MainActions", QGVAR(Repair)], _action] call EFUNC(interact_menu,addActionToClass);
            } else {
                [_type, 0, [], _action] call EFUNC(interact_menu,addActionToClass);
            };
        };

        _processedHitPoints pushBack _hitPoint;
    };
} forEach _hitSelections;

_condition = {[_this select 1, _this select 0, "", "fullRepair"] call DFUNC(canRepair)};
_statement = {[_this select 1, _this select 0, "", "fullRepair"] call DFUNC(repair)};
_action = [QGVAR(fullRepair), localize LSTRING(fullRepair), "A3\ui_f\data\igui\cfg\actions\repair_ca.paa", _statement, _condition, {}, [], "", 4] call EFUNC(interact_menu,createAction);
[_type, 0, ["ACE_MainActions", QGVAR(Repair)], _action] call EFUNC(interact_menu,addActionToClass);

// set class as initialized
_initializedClasses pushBack _type;

SETMVAR(GVAR(initializedClasses),_initializedClasses);
