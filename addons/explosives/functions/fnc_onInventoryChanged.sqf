/*
 * Author: Garth 'L-H' de Wet
 * When a take/put event handler fires and a detonator is changed hands.
 * Then take "attached" explosives.
 *
 * Arguments:
 * 0: Receiver <OBJECT>
 * 1: Giver <OBJECT>
 * 2: Item <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * Handled by CBA
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_receiver", "_giver", "_item"];
TRACE_3("params",_receiver,_giver,_item);

private ["_config", "_detonators"];

if (_receiver != ace_player) exitWith {};

_config = ConfigFile >> "CfgWeapons" >> _item;
if (isClass _config && {getNumber(_config >> "ACE_Detonator") == 1}) then {
    private ["_clackerItems"];
    _clackerItems = _giver getVariable [QGVAR(Clackers), []];
    _receiver setVariable [QGVAR(Clackers), (_receiver getVariable [QGVAR(Clackers), []]) + _clackerItems, true];

    _detonators = [_giver] call FUNC(getDetonators);
    if (count _detonators == 0) then {
        _giver setVariable [QGVAR(Clackers), nil, true];
    };
};
