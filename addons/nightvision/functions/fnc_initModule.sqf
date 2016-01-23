/*
 * Author: BaerMitUmlaut
 * Initializes the settings for the disable NVGs in sight module.
 *
 * Arguments:
 * 0: Module <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_module] call ace_nightvision_fnc_initModule
 *
 * Public: No
 */

#include "script_component.hpp"

params ["_module"];

[_module, QGVAR(disableNVGsWithSights), "disableNVGsWithSights"] call EFUNC(common,readSettingFromModule);
