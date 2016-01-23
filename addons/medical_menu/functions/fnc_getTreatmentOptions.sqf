/*
 * Author: Glowbal
 * Grab available treatment options for given category
 *
 * Arguments:
 * 0: The medic <OBJECT>
 * 1: The patient <OBJECT>
 * 2: Category name <STRING>
 *
 * Return Value:
 * Available actions <ARRAY>
 *
 * Exmaple:
 * [ACE_player, poor_dude, "some category"] call ace_medical_menu_fnc_getTreatmentOptions
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_player", "_target", "_name"];

private ["_actions", "_collectedActions", "_bodyPart"];

if (!([ACE_player, _target, ["isNotInside"]] call EFUNC(common,canInteractWith))) exitWith {[]};

_actions = if (EGVAR(medical,level) == 2) then {
    GVAR(actionsAdvanced);
} else {
    GVAR(actionsBasic);
};

_collectedActions = [];

_bodyPart = EGVAR(medical,SELECTIONS) select GVAR(selectedBodyPart);
{
    _x params ["", "_currentCategory", "_currentCondition"];
    if (_name == _currentCategory && {call _currentCondition}) then {
        _collectedActions pushBack _x;
    };
    nil
} count _actions;

_collectedActions // return
