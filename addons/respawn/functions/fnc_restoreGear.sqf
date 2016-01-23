/*
 * Author: bux578, commy2
 * Restores previously saved gear.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: All Gear based on return value of ACE_common_fnc_getAllGear <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [ACE_Player, stored_allGear, active_weapon_muzzle_and_mode] call ace_respawn_fnc_restoreGear
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_unit", "_allGear", "_activeWeaponAndMuzzle"];

// restore all gear
[_unit, _allGear, true, true] call EFUNC(common,setAllGear);

// restore the last active weapon, muzzle and weaponMode
_activeWeaponAndMuzzle params ["_activeWeapon", "_activeMuzzle", "_activeWeaponMode"];

if (
    (_activeMuzzle != "") &&
    {_activeMuzzle != _activeWeapon} &&
    {_activeMuzzle in getArray (configFile >> "CfgWeapons" >> _activeWeapon >> "muzzles")}
) then {
    _unit selectWeapon _activeMuzzle;
} else {
    if (_activeWeapon != "") then {
        _unit selectWeapon _activeWeapon;
    };
};

if (currentWeapon _unit != "") then {
    private _index = 0;

    while {
        _index < 100 && {currentWeaponMode _unit != _activeWeaponMode}
    } do {
        _unit action ["SwitchWeapon", _unit, _unit, _index];
        _index = _index + 1;
    };
};
