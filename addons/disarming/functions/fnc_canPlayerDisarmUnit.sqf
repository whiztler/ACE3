/*
 * Author: PabstMirror
 *
 * Checks the conditions for being able to disarm a unit
 *
 * Arguments:
 * 0: Player <OBJECT>
 * 1: Target <OBJECT>
 *
 * Return Value:
 * Can Be Disarm Target <BOOL>
 *
 * Example:
 * [player, cursorTarget] call ace_disarming_fnc_canPlayerDisarmUnit
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_player", "_target"];

([_target] call FUNC(canBeDisarmed)) &&
{([_player, _target, []] call EFUNC(common,canInteractWith))}
