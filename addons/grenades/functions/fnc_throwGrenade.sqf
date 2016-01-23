/*
 * Author: commy2
 * Adjust the grenades throwing direction and speed to the selected throwing mode.
 *
 * Arguments:
 * 0: unit - Object the event handler is assigned to <OBJECT>
 * 1: weapon - Fired weapon <STRING>
 * 2: muzzle - Muzzle that was used <STRING>
 * 3: mode - Current mode of the fired weapon <STRING>
 * 4: ammo - Ammo used <STRING>
 * 5: magazine - magazine name which was used <STRING>
 * 6: projectile - Object of the projectile that was shot <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [clientFiredBIS-XEH] call ace_grenades_fnc_throwGrenade
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_unit", "_weapon", "", "", "_ammo", "", "_projectile"];

if (_weapon != "Throw") exitWith {};

// http://feedback.arma3.com/view.php?id=12340
if (isNull _projectile) then {
    _projectile = nearestObject [_unit, _ammo];
};

private _config = configFile >> "CfgAmmo" >> _ammo;

// handle special grenades
if (local _unit) then {
    if (getNumber (_config >> QGVAR(flashbang)) == 1) then {
        private _fuzeTime = getNumber (_config >> "explosionTime");

        [FUNC(flashbangThrownFuze), [_projectile], _fuzeTime, 0] call EFUNC(common,waitAndExecute);
    };
};

if (getNumber (_config >> QGVAR(flare)) == 1) then {
    private _fuzeTime = getNumber (_config >> "explosionTime");
    private _timeToLive = getNumber (_config >> "timeToLive");
    private _color = getArray (_config >> QGVAR(color));
    private _intensity = _color deleteAt 3;

    [FUNC(flare), [_projectile, _color, _intensity, _timeToLive], _fuzeTime, 0] call EFUNC(common,waitAndExecute);
};

// handle throw modes
if (_unit != ACE_player) exitWith {};

private _mode = missionNamespace getVariable [QGVAR(currentThrowMode), 0];

if (_mode != 0) then {
    private _velocity = velocity _projectile;

    switch (_mode) do {
        //high throw
        case 1 : {
            _velocity = [
            0.5 * (_velocity select 0),
            0.5 * (_velocity select 1),
            [0, 0, 0] distance (_velocity vectorMultiply 0.5)
            ];
        };
        //precise throw
        case 2 : {
            _velocity = (_unit weaponDirection _weapon) vectorMultiply (vectorMagnitude _velocity);
        };
        //roll grande
        case 3 : {
            //@todo
        };
        //drop grenade
        case 4 : {
            _velocity = [0, 0, 0];
        };
    };

    _projectile setVelocity _velocity;
};
