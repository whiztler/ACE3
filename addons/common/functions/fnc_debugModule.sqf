/*
 * Author: Glowbal
 * ?
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_entity"];

GVAR(LOGDISPLAY_LEVEL) = call compile (_entity getVariable ["logDisplayLevel","4"]);
GVAR(LOGLEVEL) = call compile (_entity getVariable ["logLevel","4"]);
