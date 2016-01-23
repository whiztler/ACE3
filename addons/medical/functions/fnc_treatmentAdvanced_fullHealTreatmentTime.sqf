/*
 * Author: Ruthberg
 * Calculates the personal aid kit treatment time based on amount of damage to heal
 *
 * Arguments:
 * unit <OBJECT>
 *
 * Return Value:
 * treatment time <NUMBER>
 *
 * Example:
 * [_target] call ace_medical_fnc_treatmentAdvanced_fullHealTreatmentTime
 *
 * Public: No
 */
#include "script_component.hpp"

private "_totalDamage";

_totalDamage = 0;

{
    _totalDamage = _totalDamage + _x;
} forEach (_this getVariable [QGVAR(bodyPartStatus), []]);

(10 max (_totalDamage * 10) min 120)
