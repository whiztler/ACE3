/*
 * Author: Glowbal
 * Module for adjusting the medical menu settings
 *
 * Arguments:
 * 0: The module logic <LOGIC>
 * 1: units <ARRAY>
 * 2: activated <BOOL>
 *
 * Return Value:
 * None <NIL>
 *
 * Public: No
 */

#include "script_component.hpp"

params ["_logic", "", "_activated"];

if !(_activated) exitWith {};

[_logic, QGVAR(allow), "allow"] call EFUNC(common,readSettingFromModule);
