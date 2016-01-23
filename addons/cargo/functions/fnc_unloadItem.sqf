/*
 * Author: Glowbal, ViperMaul
 * Unload object from vehicle.
 *
 * Arguments:
 * 0: Item <OBJECT or STRING>
 * 1: Vehicle <OBJECT>
 *
 * Return value:
 * Object unloaded <BOOL>
 *
 * Example:
 * [object, vehicle] call ace_cargo_fnc_unloadItem
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_item", "_vehicle"];
private ["_loaded", "_space", "_itemSize", "_emptyPos", "_validVehiclestate"];

if !([_item, _vehicle] call FUNC(canUnloadItem)) exitWith {
    false
};

_itemClass = if (_item isEqualType "") then {_item} else {typeOf _item};

_validVehiclestate = true;
_emptyPos = [];
if (_vehicle isKindOf "Ship" ) then {
    if !(speed _vehicle <1 && {(((getPosATL _vehicle) select 2) < 2)}) then {_validVehiclestate = false};
    TRACE_1("SHIP Ground Check", getPosATL _vehicle );
    _emptyPos = ((getPosASL _vehicle) call EFUNC(common,ASLtoPosition) findEmptyPosition [0, 15, _itemClass]); // TODO: if spot is underwater pick another spot.
} else {
    if (_vehicle isKindOf "Air" ) then {
        if !(speed _vehicle <1 && {isTouchingGround _vehicle})  then {_validVehiclestate = false};
        TRACE_1("Vehicle Ground Check", isTouchingGround _vehicle);
        _emptyPos = (getPosASL _vehicle) call EFUNC(common,ASLtoPosition);
        _emptyPos = [(_emptyPos select 0) + random(5), (_emptyPos select 1) + random(5), _emptyPos select 2 ];
    } else {
        if !(speed _vehicle <1 && {(((getPosATL _vehicle) select 2) < 2)})  then {_validVehiclestate = false};
        TRACE_1("Vehicle Ground Check", isTouchingGround _vehicle);
        _emptyPos = ((getPosASL _vehicle) call EFUNC(common,ASLtoPosition) findEmptyPosition [0, 13, _itemClass]);
    };
};

TRACE_1("getPosASL Vehicle Check", getPosASL _vehicle);
if (!_validVehiclestate) exitWith {false};

if (count _emptyPos == 0) exitWith {false};

_loaded = _vehicle getVariable [QGVAR(loaded), []];
_loaded deleteAt (_loaded find _item);
_vehicle setVariable [QGVAR(loaded), _loaded, true];

_space = [_vehicle] call FUNC(getCargoSpaceLeft);
_itemSize = [_item] call FUNC(getSizeItem);
_vehicle setVariable [QGVAR(space), (_space + _itemSize), true];

if (_item isEqualType objNull) then {
    detach _item;
    _item setPosASL (_emptyPos call EFUNC(common,PositiontoASL));
    ["hideObjectGlobal", [_item, false]] call EFUNC(common,serverEvent);
} else {
    createVehicle [_item, _emptyPos, [], 0, ""];
};

true
