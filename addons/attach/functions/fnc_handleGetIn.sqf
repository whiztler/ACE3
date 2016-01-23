/*
 * Author: PabstMirror
 * Handles when a unit gets in to a vehicle.
 *
 * Arguments:
 * 0: vehicle <OBJECT>
 * 1: dunno <OBJECT>
 * 2: unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [car2, x, player] call ACE_attach_fnc_handleGetIn
 *
 * Public: No
 */
#include "script_component.hpp"

params ["", "", "_unit"];
TRACE_1("params",_unit);

if (!local _unit) exitWith {};

private ["_attachedList"];

_attachedList = _unit getVariable [QGVAR(attached), []];
if ((count _attachedList) == 0) exitWith {};

(_attachedList select 0) params ["_xObject"];
if (!isNull _xObject) then {
    TRACE_1("detaching and moving attached light",_xObject);
    detach _xObject;
    _xObject setPos ((getPos _unit) vectorAdd [0, 0, -1000]);
    [{
        params ["_detachedLight"];
        TRACE_1("delayed delete",_detachedLight);
        deleteVehicle _detachedLight;
    }, [_xObject], 2] call EFUNC(common,waitAndExecute);
    (_attachedList select 0) set [0, objNull];
};

_unit setVariable [QGVAR(attached), _attachedList, true];
