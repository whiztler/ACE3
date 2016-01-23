/*
 * Author: esteldunedain
 * Initializes the Hearing module.
 *
 * Arguments:
 * Whatever the module provides. (I dunno.)
 *
 * Return Value:
 * None
 */
#include "script_component.hpp"

params ["_logic"];

[_logic, QGVAR(enableCombatDeafness), "EnableCombatDeafness"] call EFUNC(common,readSettingFromModule);

// Do Not Force - read module setting only non-default is set due to using SCALAR
if ((_logic getVariable "DisableEarRinging") != -1) then {
    [_logic, QGVAR(DisableEarRinging), "DisableEarRinging"] call EFUNC(common,readSettingFromModule);
};

[_logic, QGVAR(enabledForZeusUnits), "enabledForZeusUnits"] call EFUNC(common,readSettingFromModule);
[_logic, QGVAR(autoAddEarplugsToUnits), "autoAddEarplugsToUnits"] call EFUNC(common,readSettingFromModule);
ACE_LOGINFO("Hearing Module Initialized.");
