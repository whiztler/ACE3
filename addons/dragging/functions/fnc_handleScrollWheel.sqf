/*
 * Author: L-H, commy2
 *
 * Handles raising and lowering the dragged weapon to be able to place it on top of objects.
 *
 * Arguments:
 * 0: Scroll amount <NUMBER>
 *
 * Return Value:
 * Handled or not. <BOOL>
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_scrollAmount"];

private ["_unit", "_carriedItem", "_position", "_maxHeight"];

_unit = ACE_player;

// EH is always assigned. Exit and don't overwrite input if not carrying
if !(_unit getVariable [QGVAR(isCarrying), false]) exitWith {false};

// move carried item 15 cm per scroll interval
_scrollAmount = _scrollAmount * 0.15;

_carriedItem = _unit getVariable [QGVAR(carriedObject), objNull];

//disabled for persons
if (_carriedItem isKindOf "CAManBase") exitWith {false};

_position = getPosATL _carriedItem;
_maxHeight = (_unit modelToWorldVisual [0,0,0]) select 2;

_position set [2, ((_position select 2) + _scrollAmount min (_maxHeight + 1.5)) max _maxHeight];

// move up/down object and reattach at current position
detach _carriedItem;
_carriedItem setPosATL _position;
_carriedItem attachTo [_unit];

true
