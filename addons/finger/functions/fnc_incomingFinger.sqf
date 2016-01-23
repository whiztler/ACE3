/*
 * Author: TheDrill, PabstMirror
 * Recieve an finger event, adds to the array (or updates if already present) and starts PFEH if not already running
 *
 * Arguments:
 * 0: Source Unit (can be self) <OBJECT>
 * 1: Position being pointed at (from positionCameraToWorld) <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [bob, [1,2,3]] call ace_finger_fnc_incomingFinger;
 *
 * Public: No
 */
#include "script_component.hpp"

private ["_data", "_fingerPos"];

params ["_sourceUnit", "_fingerPosPrecise"];

//add some random float to location if it's not our own finger:
_fingerPos = if (_sourceUnit == ACE_player) then {
    _fingerPosPrecise
} else {
    _fingerPosPrecise vectorAdd [random (2*FP_RANDOMIZATION_X) - FP_RANDOMIZATION_X, random (2*FP_RANDOMIZATION_X) - FP_RANDOMIZATION_X, random (2*FP_RANDOMIZATION_Y) - FP_RANDOMIZATION_Y]
};

_data = [ACE_diagTime, _fingerPos, ([_sourceUnit, false, true] call EFUNC(common,getName))];
HASH_SET(GVAR(fingersHash), _sourceUnit, _data);

if (GVAR(pfeh_id) == -1) then {
    GVAR(pfeh_id) = [DFUNC(perFrameEH), 0, []] call CBA_fnc_addPerFrameHandler;
};
