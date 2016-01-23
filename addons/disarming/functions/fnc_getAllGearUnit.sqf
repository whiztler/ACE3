/*
 * Author: PabstMirror
 *
 * Helper function to get all gear of a unit.
 *
 * Arguments:
 * 0: Target <OBJECT>
 *
 * Return Value:
 * Array of 2 arrays, classnames and count<ARRAY>
 *
 * Example:
 * [["ace_bandage"],[2]] = [bob] call ace_disarming_fnc_getAllGearUnit
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_target"];

private ["_allItems", "_classnamesCount", "_index", "_uniqueClassnames"];

_allItems = (((items _target) + (assignedItems _target)) - (weapons _target)) + (weapons _target) + (magazines _target);

if ((backpack _target) != "") then {
    _allItems pushBack (backpack _target);
};
if ((vest _target) != "") then {
    _allItems pushBack (vest _target);
};
if ((uniform _target) != "") then {
    _allItems pushBack (uniform _target);
};
if ((headgear _target) != "") then {
    _allItems pushBack (headgear _target);
};
//What kind of asshole takes a man's glasses?
if ((goggles _target) != "") then {
    _allItems pushBack (goggles _target);
};

_uniqueClassnames = [];
_classnamesCount = [];
//Filter unique and count
{
    _index = _uniqueClassnames find _x;
    if (_index != -1) then {
        _classnamesCount set [_index, ((_classnamesCount select _index) + 1)];
    } else {
        _uniqueClassnames pushBack _x;
        _classnamesCount pushBack 1;
    };
} forEach _allItems;

[_uniqueClassnames, _classnamesCount]
