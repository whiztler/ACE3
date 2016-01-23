    /*
 * Author: KoffeinFlummi, Glowbal, commy2
 * Main HandleDamage EH function.
 *
 * Arguments:
 * 0: Unit That Was Hit <OBJECT>
 * 1: Name Of Hit Selection <STRING>
 * 2: Amount Of Damage <NUMBER>
 * 3: Shooter <OBJECT>
 * 4: Projectile <OBJECT/STRING>
 * 5: HitPointIndex (-1 for structural) <NUMBER>
 *
 * Return Value:
 * Damage To Be Inflicted <NUMBER>
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_unit", "_selection", "_damage", "_shooter", "_projectile", "_hitPointIndex"];
TRACE_5("ACE_DEBUG: HandleDamage Called",_unit, _selection, _damage, _shooter, _projectile);

// bug, apparently can fire for remote units in special cases
if !(local _unit) exitWith {
    TRACE_2("ACE_DEBUG: HandleDamage on remote unit!",_unit, isServer);
    nil
};

private ["_damageReturn",  "_typeOfDamage", "_minLethalDamage", "_newDamage", "_typeIndex", "_preventDeath"];

// bug, assumed fixed, @todo excessive testing, if nothing happens remove
if (_projectile isEqualType objNull) then {
    _projectile = typeOf _projectile;
    _this set [4, _projectile];
};

TRACE_3("ACE_DEBUG: HandleDamage",_selection,_damage,_unit);

// If damage is in dummy hitpoints, "hands" and "legs", don't change anything
if (_selection == "hands") exitWith {_unit getHit "hands"};
if (_selection == "legs") exitWith {_unit getHit "legs"};
if (_selection == "arms") exitWith {_unit getHit "arms"};

// Deal with the new hitpoint and selection names introduced with Arma v1.50 and later.
// This will convert new selection names into selection names that the medical system understands
// TODO This should be cleaned up when we revisit the medical system at a later stage
// and instead we should deal with the new hitpoints directly
_selection = [_unit, _selection, _hitPointIndex] call FUNC(translateSelections);
_this set [1, _selection]; // ensure that the parameters are set correctly

// If the damage is being weird, we just tell it to fuck off. Ignore: "hands", "legs", "arms"
if (_selection != "" && {!(_selection in GVAR(SELECTIONS))}) exitWith {0};

// Exit if we disable damage temporarily
if !(_unit getVariable [QGVAR(allowDamage), true]) exitWith {
    TRACE_3("ACE_DEBUG: HandleDamage damage disabled.",_selection,damage _unit,_unit);
    if (_selection == "") then {
        damage _unit
    } else {
        _unit getHit _selection
    };
};

// Get return damage
_damageReturn = _damage;

_newDamage = _this call FUNC(handleDamage_caching);
// handleDamage_caching may have modified the projectile string
_typeOfDamage = [_projectile] call FUNC(getTypeOfDamage);

TRACE_3("ACE_DEBUG: HandleDamage caching new damage",_selection,_newDamage,_unit);

_typeIndex = (GVAR(allAvailableDamageTypes) find _typeOfDamage);
_minLethalDamage = if (_typeIndex >= 0) then {
    GVAR(minLethalDamages) select _typeIndex
} else {
    0.01
};

if (vehicle _unit != _unit && {!(vehicle _unit isKindOf "StaticWeapon")} && {isNull _shooter} && {_projectile == ""} && {_selection == ""}) then {
    if (GVAR(enableVehicleCrashes)) then {
        _selection = GVAR(SELECTIONS) select (floor(random(count GVAR(SELECTIONS))));
    };
};

if ((_minLethalDamage <= _newDamage) && {[_unit, [_selection] call FUNC(selectionNameToNumber), _newDamage] call FUNC(determineIfFatal)}) then {
    if ((_unit getVariable [QGVAR(preventInstaDeath), GVAR(preventInstaDeath)])) exitwith {
        _damageReturn = 0.9;
    };
    if ([_unit, false, true] call FUNC(setDead)) then {
        _damageReturn = 1;
    } else {
        _damageReturn = _damageReturn min 0.89;
    };
} else {
    _damageReturn = _damageReturn min 0.89;
};

[_unit] call FUNC(addToInjuredCollection);

if (_unit getVariable [QGVAR(preventInstaDeath), GVAR(preventInstaDeath)]) exitWith {
    if (vehicle _unit != _unit and {damage (vehicle _unit) >= 1}) then {
        [_unit] call EFUNC(common,unloadPerson);
    };

    private "_delayedUnconsicous";
    _delayedUnconsicous = false;
    if (vehicle _unit != _unit and {damage (vehicle _unit) >= 1}) then {
        [_unit] call EFUNC(common,unloadPerson);
        _delayedUnconsicous = true;
    };

    if (_damageReturn >= 0.9 && {_selection in ["", "head", "body"]}) exitWith {
        if (_unit getVariable ["ACE_isUnconscious", false]) exitwith {
            [_unit, false, true] call FUNC(setDead);
            0.89;
        };
        if (_delayedUnconsicous) then {
            [{
                [_this select 0, true] call FUNC(setUnconscious);
            }, [_unit], 0.7, 0] call EFUNC(common,waitAndExecute);
        } else {
            [{
                [_this select 0, true] call FUNC(setUnconscious);
            }, [_unit]] call EFUNC(common,execNextFrame);
        };
        0.89;
    };
    _damageReturn min 0.89;
};

if (((_unit getVariable [QGVAR(enableRevive), GVAR(enableRevive)]) > 0) && {_damageReturn >= 0.9} && {_selection in ["", "head", "body"]}) exitWith {
    if (vehicle _unit != _unit and {damage (vehicle _unit) >= 1}) then {
        [_unit] call EFUNC(common,unloadPerson);
    };
    [_unit, false, true] call FUNC(setDead);
    0.89;
};

TRACE_3("ACE_DEBUG: HandleDamage damage return",_selection,_damageReturn,_unit);

_damageReturn
