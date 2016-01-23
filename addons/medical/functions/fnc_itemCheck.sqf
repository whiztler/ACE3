/*
 * Author: KoffeinFlummi
 * Replaces vanilla items with ACE ones.
 *
 * Arguments:
 * 0: The unit <OBJECT>
 *
 * ReturnValue:
 * None
 *
 * Public: Yes
 */

#include "script_component.hpp"

params ["_unit"];

while {({_x == "FirstAidKit"} count items _unit) > 0} do {
    _unit removeItem "FirstAidKit";
    if (GVAR(level) >= 2) then {
        _unit addItem "ACE_fieldDressing";
        _unit addItem "ACE_packingBandage";
        _unit addItem "ACE_morphine";
        _unit addItem "ACE_tourniquet";
    } else {
        _unit addItem "ACE_fieldDressing";
        _unit addItem "ACE_fieldDressing";
        _unit addItem "ACE_morphine";
    };
};

while {({_x == "Medikit"} count items _unit) > 0} do {
    _unit removeItem "Medikit";
    if (GVAR(level) >= 2) then {
        _unit addItemToBackpack "ACE_fieldDressing";
        _unit addItemToBackpack "ACE_packingBandage";
        _unit addItemToBackpack "ACE_packingBandage";
        _unit addItemToBackpack "ACE_epinephrine";
        _unit addItemToBackpack "ACE_morphine";
        _unit addItemToBackpack "ACE_salineIV_250";
        _unit addItemToBackpack "ACE_tourniquet";
    } else {
        _unit addItemToBackpack "ACE_epinephrine";
        _unit addItemToBackpack "ACE_epinephrine";
        _unit addItemToBackpack "ACE_epinephrine";
        _unit addItemToBackpack "ACE_epinephrine";
        _unit addItemToBackpack "ACE_bloodIV";
        _unit addItemToBackpack "ACE_bloodIV";
    };
};
