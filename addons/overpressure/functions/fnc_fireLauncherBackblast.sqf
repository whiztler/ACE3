/*
 * Author: commy2 and esteldunedain
 * Handle fire of local launchers
 * Called from firedEHBB, only for ace_player with shot that will cause damage
 *
 * Arguments:
 * 0: Unit that fired <OBJECT>
 * 1: Weapon fired <STRING>
 * 2: Muzzle <STRING>
 * 3: Mode <STRING>
 * 4: Ammo <STRING>
 * 5: Magazine <STRING>
 * 6: Projectile <OBJECT>
 *
 * Return value:
 * None
 *
 * Example: 
 * [player, "launch_RPG32_F", "launch_RPG32_F", "Single", "R_PG32V_F", "RPG32_F", projectile] call ace_overpressure_fnc_fireLauncherBackblast;
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_firer", "_weapon", "_muzzle", "", "_ammo", "_magazine", "_projectile"];
TRACE_6("params",_firer,_weapon,_muzzle,_ammo,_magazine,_projectile);

private _position = getPosASL _projectile;
private _direction = [0, 0, 0] vectorDiff (vectorDir _projectile);

// Bake variable name and check if the variable exists, call the caching function otherwise
private _varName = format [QGVAR(values%1%2%3), _weapon, _ammo, _magazine];
private _var = if (isNil _varName) then {
    [_weapon, _ammo, _magazine] call FUNC(cacheOverPressureValues);
} else {
    missionNameSpace getVariable _varName;
};
_var params["_backblastAngle","_backblastRange","_backblastDamage"];
TRACE_3("cache",_backblastAngle,_backblastRange,_backblastDamage);

// Damage to others
private _affected = (ASLtoAGL _position) nearEntities ["CAManBase", _backblastRange];

// Let each client handle their own affected units
["overpressure", _affected, [_firer, _position, _direction, _weapon, _magazine, _ammo]] call EFUNC(common,targetEvent);

// Damage to the firer
private _distance = 2 * ([_position, _direction, _backblastRange, _firer] call FUNC(getDistance));

TRACE_1("Distance",_distance);

if (_distance < _backblastRange) then {
    private _alpha = sqrt (1 - _distance / _backblastRange);
    private _beta = sqrt 0.5;

    private _damage = _alpha * _beta * _backblastDamage;
    [_damage * 100] call BIS_fnc_bloodEffect;

    if (isClass (configFile >> "CfgPatches" >> "ACE_Medical") && {([_firer] call EFUNC(medical,hasMedicalEnabled))}) then {
        [_firer, _damage, "body", "backblast"] call EFUNC(medical,addDamageToUnit);
    } else {
        _firer setDamage (damage _firer + _damage);
    };
};

// Draw debug lines
#ifdef DEBUG_MODE_FULL
    [   _position,
        _position vectorAdd (_direction vectorMultiply _backblastRange),
        [1,1,0,1]
    ] call EFUNC(common,addLineToDebugDraw);

    private _ref = _direction call EFUNC(common,createOrthonormalReference);
    [   _position,
        _position vectorAdd (_direction vectorMultiply _backblastRange) vectorAdd ((_ref select 1) vectorMultiply _backblastRange * tan _backblastAngle),
        [1,1,0,1]
    ] call EFUNC(common,addLineToDebugDraw);
    [   _position,
        _position vectorAdd (_direction vectorMultiply _backblastRange) vectorDiff ((_ref select 1) vectorMultiply _backblastRange * tan _backblastAngle),
        [1,1,0,1]
    ] call EFUNC(common,addLineToDebugDraw);
    [   _position,
        _position vectorAdd (_direction vectorMultiply _backblastRange) vectorAdd ((_ref select 2) vectorMultiply _backblastRange * tan _backblastAngle),
        [1,1,0,1]
    ] call EFUNC(common,addLineToDebugDraw);
    [   _position,
        _position vectorAdd (_direction vectorMultiply _backblastRange) vectorDiff ((_ref select 2) vectorMultiply _backblastRange * tan _backblastAngle),
        [1,1,0,1]
    ] call EFUNC(common,addLineToDebugDraw);

    [   _position,
        _position vectorAdd (_direction vectorMultiply ((_distance/2) min _backblastRange)),
        [1,0,0,1]
    ] call EFUNC(common,addLineToDebugDraw);
#endif
