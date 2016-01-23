/*
 * Author: Glowbal
 * Handling of the open wounds & injuries upon the handleDamage eventhandler.
 *
 * Arguments:
 * 0: Unit That Was Hit <OBJECT>
 * 1: Name Of Hit Selection <STRING>
 * 2: Amount Of Damage <NUMBER>
 * 3: Shooter or source of the damage <OBJECT>
 * 4: Type of the damage done <STRING>
 *
 * Return Value:
 * None <NIL>
 *
 * Public: No
 */

#include "script_component.hpp"

private ["_bodyPartn", "_injuryTypeInfo", "_allInjuriesForDamageType", "_allPossibleInjuries", "_highestPossibleDamage", "_highestPossibleSpot", "_minDamage", "_openWounds", "_woundID", "_toAddInjury", "_painToAdd", "_bloodLoss", "_bodyPartNToAdd", "_classType", "_damageLevels", "_foundIndex", "_i", "_injury", "_maxDamage", "_pain", "_painLevel", "_selections", "_toAddClassID", "_woundsCreated"];
params ["_unit", "_selectionName", "_damage", "_typeOfProjectile", "_typeOfDamage"];
TRACE_6("ACE_DEBUG: HandleDamage_WoundsOLD Called",_unit, _selectionName, _damage, _shooter, _typeOfProjectile,_typeOfDamage);

// Convert the selectionName to a number and ensure it is a valid selection.
_bodyPartn = [_selectionName] call FUNC(selectionNameToNumber);
if (_bodyPartn < 0) exitWith {};

// Get the injury type information. Format: [typeDamage thresholds, selectionSpecific, woundTypes]
_injuryTypeInfo = missionNamespace getVariable [format[QGVAR(woundInjuryType_%1), _typeOfDamage],[[], false, []]];

// This are the available injuries for this damage type. Format [[classtype, selections, bloodloss, minimalDamage, pain], ..]
_allInjuriesForDamageType = _injuryTypeInfo select 2;
// It appears we are dealing with an unknown type of damage.

if (count _allInjuriesForDamageType == 0) then {
    // grabbing the configuration for unknown damage type
    _injuryTypeInfo = missionNamespace getVariable [QGVAR(woundInjuryType_unknown),[[], false, []]];
    _allInjuriesForDamageType = _injuryTypeInfo select 2;
};

// find the available injuries for this damage type and damage amount
_highestPossibleSpot = -1;
_highestPossibleDamage = -1;
_allPossibleInjuries = [];
{
    _damageLevels = _x select 4;
    _minDamage = _damageLevels select 0;
    _maxDamage = _damageLevels select 1;

    // Check if the damage is higher as the min damage for the specific injury
    if (_damage >= _minDamage && {_damage <= _maxDamage || _maxDamage < 0}) then {
        //_classType = _x select 0;
        _selections = _x select 1;
        //_bloodLoss = _x select 2;
        //_pain = _x select 3;

        // Check if the injury can be applied to the given selection name
        if ("All" in _selections || _selectionName in _selections) then {

            // Find the wound which has the highest minimal damage, so we can use this later on for adding the correct injuries
            if (_minDamage > _highestPossibleDamage) then {
                _highestPossibleSpot = _forEachIndex;
                _highestPossibleDamage = _minDamage;
            };

            // Store the valid possible injury for the damage type, damage amount and selection
            _allPossibleInjuries pushBack _x;
        };
    };
} forEach _allInjuriesForDamageType;

// No possible wounds available for this damage type or damage amount.
if (_highestPossibleSpot < 0) exitWith {};

// Administration for open wounds and ids
_openWounds = _unit getVariable[QGVAR(openWounds), []];
_woundID = _unit getVariable[QGVAR(lastUniqueWoundID), 1];

_painToAdd = 0;
_woundsCreated = [];
{
    if (_x select 0 <= _damage) exitWith {
        for "_i" from 0 to (1+ floor(random(_x select 1)-1)) /* step +1 */ do {

            // Find the injury we are going to add. Format [ classID, allowdSelections, bloodloss, painOfInjury, minimalDamage]
            _toAddInjury =  if (random(1) >= 0.85) then {_allInjuriesForDamageType select _highestPossibleSpot} else {_allPossibleInjuries select (floor(random (count _allPossibleInjuries)));};
            _toAddClassID = _toAddInjury select 0;
            _foundIndex = -1;

            _bodyPartNToAdd = if (_injuryTypeInfo select 1) then {_bodyPartn} else {floor(random(6))};
            // If the injury type is selection part specific, we will check if one of those injury types already exists and find the spot for it..
            if ((_injuryTypeInfo select 1)) then {
                {
                    // Check if we have an id of the given class on the given bodypart already
                    if (_x select 1 == _toAddClassID && {_x select 2 == _bodyPartNToAdd}) exitWith {
                        _foundIndex = _forEachIndex;
                    };
                } forEach _openWounds;
            };

            _injury = [];
            if (_foundIndex < 0) then {
                // Create a new injury. Format [ID, classID, bodypart, percentage treated, bloodloss rate]
                _injury = [_woundID, _toAddInjury select 0, _bodyPartNToAdd, 1, _toAddInjury select 2];

                // Since it is a new injury, we will have to add it to the open wounds array to store it
                _openWounds pushBack _injury;

                // New injuries will also increase the wound ID
                _woundID = _woundID + 1;
            } else {
                // We already have one of these, so we are just going to increase the number that we have of it with a new one.
                _injury = _openWounds select _foundIndex;
                _injury set [3, (_injury select 3) + 1];
            };
            // Store the injury so we can process it later correctly.
            _woundsCreated pushBack _injury;

            // Collect the pain that is caused by this injury
            _painToAdd = _painToAdd + (_toAddInjury select 3);
        };
    };
} forEach (_injuryTypeInfo select 0); // forEach damage thresholds

_unit setVariable [QGVAR(openWounds), _openWounds, true];

// Only update if new wounds have been created
if (count _woundsCreated > 0) then {
    _unit setVariable [QGVAR(lastUniqueWoundID), _woundID, true];
};

_painLevel = _unit getVariable [QGVAR(pain), 0];
_unit setVariable [QGVAR(pain), _painLevel + _painToAdd];
TRACE_6("ACE_DEBUG: HandleDamage_WoundsOLD",_unit, _painLevel, _painToAdd, _unit getVariable QGVAR(pain), _unit getVariable QGVAR(openWounds),_woundsCreated);
