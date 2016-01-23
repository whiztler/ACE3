/*
 * Author: KoffeinFlummi, commy2, Ruthberg
 * Handles deafness due to explosions going off near the player.
 *
 * Arguments:
 * 0: vehicle - Object the event handler is assigned to (player) <OBJECT>
 * 1: damage - Damage inflicted to the object <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [clientExplosionEvent] call ace_hearing_fnc_explosionNear
 *
 * Public: No
 */
#include "script_component.hpp"

//Only run if deafness or ear ringing is enabled:
if ((!GVAR(enableCombatDeafness)) && GVAR(DisableEarRinging)) exitWith {};

params ["_unit", "_damage"];

if (_unit != ACE_player) exitWith {};

TRACE_2("explosion near player",_unit,_damage);

private ["_strength"];
_strength = (0 max _damage) * 30;
if (_strength < 0.01) exitWith {};

[{_this call FUNC(earRinging)}, [_unit, _strength], 0.2] call EFUNC(common,waitAndExecute);
