/*
 * Author: Glowbal
 *
 *
 * Arguments:
 * none
 *
 * Return Value:
 * None
 *
 * Public: No
 */

#include "script_component.hpp"

private ["_logic"];
_logic = _this select 0;

if (isMultiplayer) exitWith {};

if (_logic getVariable ["allowconfigurationExport", false]) then {
    GVAR(serverConfigGeneration) = 1;
} else {
    GVAR(serverConfigGeneration) = 0;
};
