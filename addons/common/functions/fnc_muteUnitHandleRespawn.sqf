/*
 * Author: commy2
 * Applies speaker changes on respawn. Used because speaker is respawning breaks the speaker on non-local clients. Also resets the public object variable (broken for JIP clients, that join after respawn)
 *
 * Arguments:
 * 0: unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_unit"];

// setVariable is broken on JIP after respawn
_unit setVariable [QGVAR(muteUnitReasons), _unit getVariable [QGVAR(muteUnitReasons), []], true];

// fix mp issues with respawning and the speaker
["setSpeaker", [_unit, speaker _unit]] call FUNC(globalEvent);
