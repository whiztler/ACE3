/*
 * Author: KoffeinFlummi
 * Local callback when the morphine treatment is complete
 *
 * Arguments:
 * 0: The medic <OBJECT>
 * 1: The patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

#include "script_component.hpp"
#define MORPHINEHEAL 0.4

private ["_morphine", "_pain"];
params ["_target"];

// reduce pain, pain sensitivity
_morphine = ((_target getVariable [QGVAR(morphine), 0]) + MORPHINEHEAL) min 1;
_target setVariable [QGVAR(morphine), _morphine, true];
_pain = ((_target getVariable [QGVAR(pain), 0]) - MORPHINEHEAL) max 0;
_target setVariable [QGVAR(pain), _pain, true];

// @todo overdose
