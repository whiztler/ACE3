/*
 * Author: PabstMirror
 * Deletes a waypoint from the "device"
 * Device saving not implemented yet, just save to player object
 *
 * Arguments:
 * 0: Waypoint Index <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * ["Hill 55", [41,324, 12]] call ace_microdagr_fnc_deviceDeleteWaypoint
 *
 * Public: No
 */
#include "script_component.hpp"

private "_waypoints";
params ["_wpIndex"];

_waypoints = ACE_player getVariable [QGVAR(waypoints), []];

if ((_wpIndex < 0) || (_wpIndex > ((count _waypoints) - 1))) exitWith {ERROR("out of bounds wp");};

_waypoints deleteAt _wpIndex;
ACE_player setVariable [QGVAR(waypoints), _waypoints];
