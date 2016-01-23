/*
 * Author: Glowbal
 * Advanced HandleDamage EH function.
 *
 * Arguments:
 * 0: Unit That Was Hit <OBJECT>
 * 1: Name Of Hit Selection <STRING>
 * 2: Amount Of Damage <NUMBER>
 * 3: Shooter <OBJECT>
 * 4: Projectile <STRING>
 * 5: Current damage to be returned <NUMBER>
 * 6: Type of Damage <STRING>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

#include "script_component.hpp"

private ["_typeOfProjectile", "_part", "_damageBodyParts", "_hitPoints"];
params ["_unit", "_selectionName", "_amountOfDamage", "_sourceOfDamage", "_typeOfProjectile", "_hitPointNumber", "_newDamage"];

_part = [_selectionName] call FUNC(selectionNameToNumber);
if (_part < 0) exitWith {};

_hitPoints = ["HitHead", "HitBody", "HitLeftArm", "HitRightArm", "HitLeftLeg", "HitRightLeg"];
// Sorting out the damage
_damageBodyParts = _unit getVariable [QGVAR(bodyPartStatus), [0,0,0,0,0,0]];

_damageBodyParts set [_part, (_damageBodyParts select _part) + _newDamage];
_unit setVariable [QGVAR(bodyPartStatus), _damageBodyParts, true];

_typeOfDamage = [_typeOfProjectile] call FUNC(getTypeOfDamage);

[_unit, _selectionName, _newDamage, _typeOfProjectile, _typeOfDamage] call FUNC(handleDamage_assignWounds);

// TODO Disabled until implemented fully
//if (GVAR(enableAirway)) then {
//    [_unit,_selectionName,_newDamage,_sourceOfDamage, _typeOfDamage] call FUNC(handleDamage_airway);
//};
//if (GVAR(enableFractures)) then {
//    [_unit,_selectionName,_newDamage,_sourceOfDamage, _typeOfDamage] call FUNC(handleDamage_fractures);
//};
//if (GVAR(enableInternalBleeding)) then {
//    [_unit,_selectionName,_newDamage,_sourceOfDamage, _typeOfDamage] call FUNC(handleDamage_internalInjuries);
//};

if (alive _unit && {!(_unit getVariable ["ACE_isUnconscious", false])}) then {
    // If it reaches this, we can assume that the hit did not kill this unit, as this function is called 3 frames after the damage has been passed.
    if ([_unit, _part, if (_part > 1) then {_newDamage * 1.3} else {_newDamage * 2}] call FUNC(determineIfFatal)) then {
        [_unit] call FUNC(setUnconscious);
    };
};
