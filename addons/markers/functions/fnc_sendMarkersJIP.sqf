/*
 * Author: commy2
 * Server: Recives a dummy logic, sends marker data back to the owner.
 *
 * Arguments:
 * 0: Logic <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [onUnloadEvent] call ace_markers_fnc_sendMarkerJIP;
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_logic"];
TRACE_1("params",_logic);

[
    QGVAR(setMarkerJIP),
    [_logic],
    [GETGVAR(allMapMarkers,[]), GETGVAR(allMapMarkersProperties,[]), _logic]
] call EFUNC(common,targetEvent);
