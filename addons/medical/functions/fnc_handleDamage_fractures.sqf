/*
 * Author: Glowbal
 * Handling of the fracture injuries upon the handleDamage eventhandler.
 *
 * Arguments:
 * 0: Unit That Was Hit <OBJECT>
 * 1: Name Of Hit Selection <STRING>
 * 2: Amount Of Damage <NUMBER>
 * 3: Shooter or source of the damage <OBJECT>
 * 4: Type of the damage done <STRING>
 *
 * Return Value:
 * None <NIL>
 *
 * Public: No
 */

#include "script_component.hpp"

private ["_bodyPartn", "_fractures", "_fractureType"];
params ["_unit", "_selectionName", "_amountOfDamage", "_sourceOfDamage", "_typeOfDamage"];
_bodyPartn = [_selectionName] call FUNC(selectionNameToNumber);

_fractureType = 1;
if (_amountOfDamage > 0.05) then {

    // TODO specify fractures based off typeOfInjury details better.
    switch (_typeOfDamage) do {
        case "Bullet": {
            _fractureType = round(random(2));
        };
        case "Grenade": {
            _fractureType = round(random(2));
            if (_fractureType < 1) then {
                _fractureType = 1;
            };
        };
        case "Explosive": {
            _fractureType = round(random(2));
            if (_fractureType < 1) then {
                _fractureType = 1;
            };
        };
        case "Shell": {
            _fractureType = round(random(2));
            if (_fractureType < 1) then {
                _fractureType = 1;
            };
        };
        case "Unknown": {
            _fractureType = round(random(1));
        };
        case "VehicleCrash": {
            _fractureType = round(random(0));
        };
        default {
            _fractureType = round(random(1));
        };
    };

    private ["_fractures", "_fractureID", "_amountOf"];
    _fractures = _unit getVariable[QGVAR(fractures), []];
    _fractureID = 1;
    _amountOf = count _fractures;
    if (_amountOf > 0) then {
        _fractureID = (_fractures select (_amountOf - 1) select 0) + 1;
    };
    _fractures pushBack [_fractureID, _fractureType, _bodyPartn, 1 /* percentage treated */];
    _unit setVariable [QGVAR(fractures), _fractures, true];
};
