/*
 * Author: commy2
 * Handle death.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Public: No
*/
#include "script_component.hpp"

params ["_unit"];

if (!isNull (GETMVAR(ladder,objNull)) && {GVAR(ladder) in attachedObjects _unit}) then {
    [_unit, GVAR(ladder)] call FUNC(cancelTLdeploy);
};
