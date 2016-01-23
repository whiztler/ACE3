/*
 * Author: Glowbal
 * Module for adjusting the cargo settings
 *
 * Arguments:
 * 0: The module logic <OBJECT>
 * 1: Synchronized units <ARRAY>
 * 2: Activated <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * function = "ace_cargo_fnc_loadItem"
 *
 * Public: No
 */
#include "script_component.hpp"

if (!isServer) exitWith {};

params ["_logic", "_units", "_activated"];

if (!_activated) exitWith {};

[_logic, QGVAR(enable), "enable"] call EFUNC(common,readSettingFromModule);

ACE_LOGINFO("Cargo Module Initialized.");
