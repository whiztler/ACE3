/*
 * Author: Glowbal
 * Check if all items are present between the patient and the medic.
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Items <ARRAY<STRING>>
 *
 * ReturnValue:
 * Has the items <BOOL>
 *
 * Public: Yes
 */

#include "script_component.hpp"

private ["_medic", "_patient", "_items", "_return"];
params ["_medic", "_patient", "_items"];

_return = true;
{
    //
    if (_x isEqualType [] && {({[_medic, _patient, _x] call FUNC(hasItem)}count _x == 0)}) exitwith {
        _return = false;
    };
    if (_x isEqualType "" && {!([_medic, _patient, _x] call FUNC(hasItem))}) exitwith {
        _return = false;
    };
}foreach _items;

_return
