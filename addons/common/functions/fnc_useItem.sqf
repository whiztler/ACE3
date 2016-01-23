/*
 * Author: Glowbal
 * Use item
 *
 * Arguments:
 * 0: unit <OBJECT>
 * 1: item <STRING>
 *
 * Return Value:
 * if item has been used. <BOOL>
 *
 * Public: Yes
 */
#include "script_component.hpp"

params ["_unit", "_item", ["_vehicleUsage", false]];

private _return = false;

if !(_vehicleUsage) then {
    if (_item != "") then {
        if (_item in items _unit) then {
            _unit removeItem _item;
            _return = true;
        } else {
            if (_item in assignedItems _unit) then {
                _unit unlinkItem _item;
                _return = true;
            };
        };
    };
//} else {
    // @todo implement shared item functionality for with vehicles.
};

_return
