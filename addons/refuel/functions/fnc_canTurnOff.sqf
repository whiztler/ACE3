/*
 * Author: GitHawk
 * Check if a unit can turn off a fuel nozzle
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Nozzle <OBJECT>
 *
 * Return Value:
 * Can turn off <BOOL>
 *
 * Example:
 * [player, nozzle] call ace_refuel_fnc_canTurnOff
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_unit", "_nozzle"];

if (isNull _unit  ||
    {isNull _nozzle} ||
    {!(_unit isKindOf "CAManBase")} ||
    {!local _unit} ||
    {(_nozzle distance _unit) > REFUEL_ACTION_DISTANCE}) exitWith {false};

(_nozzle getVariable [QGVAR(isRefueling), false])
