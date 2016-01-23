/*
 * Author: Garth de Wet (LH)
 * Checks whether the passed unit is an explosive specialist.
 * Either through config entry: "canDeactivateMines"
 * or
 * unit setVariable ["ACE_isEOD", true]
 *
 * Arguments:
 * 0: Unit to check if is a specialist <OBJECT>
 *
 * Return Value:
 * is the unit an EOD <BOOL>
 *
 * Example:
 * isSpecialist = [player] call FUNC(isEOD);
 *
 * Public: Yes
 */
#include "script_component.hpp"

params ["_unit"];

_unit getVariable ["ACE_isEOD", getNumber (configFile >> "CfgVehicles" >> typeOf _unit >> "canDeactivateMines") == 1] // return
