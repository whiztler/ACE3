/*
 * Author: commy2
 * Unit claims the ownership over an object. This is used to prevent multiple players from draging the same ammo box or using up the same wheel when repairing etc.
 *
 * Arguments:
 * 0: Unit that claims another object. ObjNull to remove claim. <OBJECT>
 * 1: The object that gets claimed. <OBJECT>
 * 2: Lock the claimed object aswell? (optional: false) <BOOL>
 *
 * Return Value:
 * None
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_unit", "_target", ["_lockTarget", false]];

private _owner = _target getVariable [QGVAR(owner), objNull];

if (!isNull _owner && {!isNull _unit} && {_unit != _owner}) then {
    ACE_LOGERROR("Claiming already owned object.");
};

// transfer this immediately
_target setVariable [QGVAR(owner), _unit, true];

// lock target object
if (_lockTarget) then {
    if (!isNull _unit) then {
        ["lockVehicle", _target, _target] call FUNC(targetEvent);
    } else {
        ["unlockVehicle", _target, _target] call FUNC(targetEvent);
    };
};

/*
systemChat str locked _target;
systemChat str (_target getVariable [QGVAR(lockStatus), locked _target]);
*/
