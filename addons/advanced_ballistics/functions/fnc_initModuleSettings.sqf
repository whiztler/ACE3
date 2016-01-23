/*
 * Author: Glowbal, Ruthberg
 * Module for adjusting the advanced ballistics settings
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

params ["_logic","_units", "_activated"];

if !(_activated) exitWith {};

[_logic, QGVAR(enabled), "enabled"] call EFUNC(common,readSettingFromModule);
[_logic, QGVAR(ammoTemperatureEnabled), "ammoTemperatureEnabled"] call EFUNC(common,readSettingFromModule);
[_logic, QGVAR(barrelLengthInfluenceEnabled), "barrelLengthInfluenceEnabled"] call EFUNC(common,readSettingFromModule);
[_logic, QGVAR(bulletTraceEnabled), "bulletTraceEnabled"] call EFUNC(common,readSettingFromModule);
[_logic, QGVAR(simulateForEveryone), "simulateForEveryone"] call EFUNC(common,readSettingFromModule);
[_logic, QGVAR(disabledInFullAutoMode), "disabledInFullAutoMode"] call EFUNC(common,readSettingFromModule);
[_logic, QGVAR(simulateForSnipers), "simulateForSnipers"] call EFUNC(common,readSettingFromModule);
[_logic, QGVAR(simulateForGroupMembers), "simulateForGroupMembers"] call EFUNC(common,readSettingFromModule);
[_logic, QGVAR(simulationInterval), "simulationInterval"] call EFUNC(common,readSettingFromModule);
[_logic, QGVAR(simulationRadius), "simulationRadius"] call EFUNC(common,readSettingFromModule);

GVAR(simulationInterval) = 0 max GVAR(simulationInterval) min 0.2;
