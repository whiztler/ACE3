/*
 * Author: KoffeinFlummi
 * Initializes the check-PBOs module.
 *
 * Arguments:
 * 0: The module logic <LOGIC>
 * 1: units <ARRAY>
 * 2: activated <BOOL>
 *
 * Return Value:
 * None
 *
 * Public: No
 */
#include "script_component.hpp"

if !(isServer) exitWith {};

params ["_logic", "_units", "_activated"];

if !(_activated) exitWith {};

[_logic, QGVAR(checkPBOsAction),     "Action"    ] call EFUNC(common,readSettingFromModule);
[_logic, QGVAR(checkPBOsCheckAll),   "CheckAll"  ] call EFUNC(common,readSettingFromModule);
[_logic, QGVAR(checkPBOsWhitelist),  "Whitelist" ] call EFUNC(common,readSettingFromModule);

ACE_LOGINFO_1("Check-PBOs Module Initialized. Mode: %1.",GVAR(checkPBOsAction));
