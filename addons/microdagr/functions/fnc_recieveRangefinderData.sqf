/*
 * Author: PabstMirror
 * Recieves the data packet from the vector rangefinder
 *
 * Arguments:
 * 0: Slope distance (Meters) <NUMBER>
 * 1: Azimuth (Degrees) <NUMBER>
 * 2: Inclination (Degrees) <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [1000, 45, 1] call ace_microdagr_fnc_recieveRangefinderData
 *
 * Public: No
 */
#include "script_component.hpp"

private ["_horizontalDistance", "_verticleDistance", "_targetOffset", "_targetPosASL"];

params ["_slopeDistance", "_azimuth", "_inclination"];

if (GVAR(currentWaypoint) != -2) exitWith {}; //Only take waypoint when "connected"
if (_slopeDistance < 0) exitWith {}; //Bad Data

_horizontalDistance = (cos _inclination) * _slopeDistance;
_verticleDistance = (sin _inclination) * _slopeDistance;

_targetOffset = [((sin _azimuth) * _horizontalDistance), ((cos _azimuth) * _horizontalDistance), _verticleDistance];
//This assumes the "rangefinder view" pos is very close to player, at worst the turret should only be a few meters different
_targetPosASL = (getPosASL ACE_player) vectorAdd _targetOffset;

GVAR(rangeFinderPositionASL) = _targetPosASL;
