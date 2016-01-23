/*
 * Author: bux578
 * Initializes the player
 *
 * Arguments:
 * 0: player <OBJECT>
 * 1: sides <ARRAY<OBJECT>>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, [west]] call ace_switchunits_fnc_initPlayer
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_playerUnit", "_sides"];

if (vehicle _playerUnit == _playerUnit) then {
    [_sides] call FUNC(markAiOnMap);

    _playerUnit setVariable [QGVAR(IsPlayerUnit), true, true];
    _playerUnit allowDamage false;

    GVAR(OriginalUnit) = _playerUnit;
    GVAR(OriginalName) = name _playerUnit;
    GVAR(OriginalGroup) = group _playerUnit;

    // remove all starting gear of a player
    removeAllWeapons _playerUnit;
    removeGoggles _playerUnit;
    removeHeadgear _playerUnit;
    removeVest _playerUnit;
    removeAllAssignedItems _playerUnit;
    clearAllItemsFromBackpack _playerUnit;
    removeBackpack _playerUnit;
    _playerUnit linkItem  "ItemMap";
    removeUniform _playerUnit;

    [_playerUnit, "forceWalk", "ACE_SwitchUnits", true] call EFUNC(common,statusEffect_set);

    [_playerUnit, _sides] call FUNC(addMapFunction);
};
