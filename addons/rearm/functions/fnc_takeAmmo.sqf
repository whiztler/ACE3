/*
 * Author: GitHawk
 * Starts progress bar for picking up a specific kind of magazine from an ammo truck.
 *
 * Arguments:
 * 0: Ammo Truck <OBJECT>
 * 1: Unit <OBJECT>
 * 2: Params <ARRAY>
 *   0: Magazine Classname <STRING>
 *   1: Vehicle to be armed <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [ammo_truck, player, ["500Rnd_127x99_mag_Tracer_Red", tank]] call ace_rearm_fnc_takeAmmo
 *
 * Public: No
 */
#include "script_component.hpp"

private ["_ammo", "_tmpCal", "_cal", "_idx"];

params ["_target", "_unit", "_args"];
_args params ["_magazineClass", "_vehicle"];

_ammo = getText (configFile >> "CfgMagazines" >> _magazineClass >> "ammo");
_tmpCal = getNumber (configFile >> "CfgAmmo" >> _ammo >> "ace_caliber");
_cal = 8;
if (_tmpCal > 0) then {
    _cal = _tmpCal;
} else {
    _tmpCal = getNumber (configFile >> "CfgAmmo" >> _ammo >> QGVAR(caliber));
    if (_tmpCal > 0) then {
        _cal = _tmpCal;
    } else {
        diag_log format ["[ACE] ERROR: Undefined Ammo [%1 : %2]", _ammo, inheritsFrom (configFile >> "CfgAmmo" >> _ammo)];
        if (_ammo isKindOf "BulletBase") then {
            _cal = 8;
        } else {
            _cal = 100;
        };
    };
};
_cal = round _cal;
_idx = REARM_CALIBERS find _cal;
if (_idx == -1 ) then {
    _idx = 2;
};

REARM_HOLSTER_WEAPON

[
    (REARM_DURATION_TAKE select _idx),
    [_unit, _magazineClass, _target],
    FUNC(takeSuccess),
    "",
    format [localize LSTRING(TakeAction), getText(configFile >> "CfgMagazines" >> _magazineClass >> "displayName"), getText(configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "displayName")],
    {true},
    ["isnotinside"]
] call EFUNC(common,progressBar);
