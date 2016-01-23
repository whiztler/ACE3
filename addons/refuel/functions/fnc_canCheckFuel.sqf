/*
 * Author: Jonpas, GitHawk
 * Checks if unit can check fuel.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Fuel Truck/Station <OBJECT>
 *
 * Return Value:
 * Can Check Fuel <BOOL>
 *
 * Example:
 * [player, truck] call ace_refuel_fnc_canCheckFuel
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_unit", "_target"];

!(isNull _unit ||
    {!(_unit isKindOf "CAManBase")} ||
    {!local _unit} ||
    {!alive _target} ||
    {(_target distance _unit) > REFUEL_ACTION_DISTANCE} ||
    {(_target call FUNC(getFuel) == REFUEL_INFINITE_FUEL)})
