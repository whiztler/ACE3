/*
 * Author: BaerMitUmlaut
 * Handles treatment via surgical kit per frame
 *
 * Arguments:
 * 0: Arguments <ARRAY>
 *  0: Caller <OBJECT>
 *  1: Target <OBJECT>
 * 1: Elapsed Time <NUMBER>
 * 2: Total Time <NUMBER>
 *
 * Return Value:
 * Succesful treatment started <BOOL>
 *
 * Public: No
 */
#include "script_component.hpp"


private "_bandagedWounds";
params ["_args", "_elapsedTime", "_totalTime"];
_args params ["_caller", "_target"];

_bandagedWounds = _target getVariable [QGVAR(bandagedWounds), []];

//In case two people stitch up one patient and the last wound has already been closed we can stop already
if (count _bandagedWounds == 0) exitWith { false };

//Has enough time elapsed that we can close another wound?
if ((_totalTime - _elapsedTime) <= (((count _bandagedWounds) - 1) * 5)) then {
    _bandagedWounds deleteAt 0;
    _target setVariable [QGVAR(bandagedWounds), _bandagedWounds, true];
};

true
