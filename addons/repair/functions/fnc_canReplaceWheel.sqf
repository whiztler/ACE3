/*
 * Author: commy2
 * Check if the unit can replace given wheel of the vehicle.
 *
 * Arguments:
 * 0: Unit that does the repairing <OBJECT>
 * 1: Vehicle to repair <OBJECT>
 * 2: Selected hitpoint <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [unit, vehicle, "hitpoint"] call ace_repair_fnc_canReplaceWheel
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_unit", "_target", "_hitPoint"];
TRACE_3("params",_unit,_target,_hitPoint);

if !([_unit, _target, ["isNotDragging", "isNotCarrying", "isNotOnLadder"]] call EFUNC(common,canInteractWith)) exitWith {false};

//check for GVAR(engineerSetting_Wheel) is handeled by requiredEngineer config
//check for a near wheel object is handled by claimObjects[] config

(_target getHitPointDamage _hitPoint >= 1)
