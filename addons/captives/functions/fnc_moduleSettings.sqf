/*
 * Author: PabstMirror
 * Module for captivity settings
 *
 * Arguments:
 * 0: The module logic <OBJECT>
 *
 * Return Value:
 * None <NIL>
 *
 * Public: No
 */

#include "script_component.hpp"

params ["_logic"];

[_logic, QGVAR(allowHandcuffOwnSide), "allowHandcuffOwnSide"] call EFUNC(common,readSettingFromModule);
[_logic, QGVAR(allowSurrender), "allowSurrender"] call EFUNC(common,readSettingFromModule);
[_logic, QGVAR(requireSurrender), "requireSurrender"] call EFUNC(common,readSettingFromModule);
