/*
 * Author: Glowbal
 * local Callback for the CPR treatment action on success.
 *
 * Arguments:
 * 0: The medic <OBJECT>
 * 1: The patient <OBJECT>
 *
 * Return Value:
 * Succesful treatment started <BOOL>
 *
 * Public: Yes
 */

#include "script_component.hpp"

private "_reviveStartTime";
params ["_caller","_target"];

if (_target getVariable [QGVAR(inReviveState), false]) then {
    _reviveStartTime = _target getVariable [QGVAR(reviveStartTime),0];
    if (_reviveStartTime > 0) then {
        _target setVariable [QGVAR(reviveStartTime), (_reviveStartTime + random(20)) min ACE_time];
    };
};

if (GVAR(level) > 1 && {(random 1) >= 0.6}) then {
    _target setVariable [QGVAR(inCardiacArrest), nil,true];
    _target setVariable [QGVAR(heartRate), 40];
    _target setVariable [QGVAR(bloodPressure), [50,70]];
};

[_target, "activity", LSTRING(Activity_CPR), [[_caller, false, true] call EFUNC(common,getName)]] call FUNC(addToLog);
[_target, "activity_view", LSTRING(Activity_CPR), [[_caller, false, true] call EFUNC(common,getName)]] call FUNC(addToLog); // TODO expand message

true;
