/*
 * Author: commy2
 * Removes the magazine of the units rangefinder.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * player call ace_common_fnc_removeBinocularMagazine
 *
 * Public: Yes
 */
#include "script_component.hpp"

params [["_unit", objNull, [objNull]]];

private _binocular = binocular _unit;
private _selectBinocular = currentWeapon _unit == _binocular;

_unit addWeapon _binocular;

if (_selectBinocular) then {
    _unit selectWeapon _binocular;
};
