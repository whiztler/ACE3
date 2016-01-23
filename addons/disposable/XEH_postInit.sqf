// by commy2
#include "script_component.hpp"

if (!hasInterface) exitWith {};

["inventoryDisplayLoaded", {
    [ACE_player, _this select 0] call FUNC(updateInventoryDisplay)
}] call EFUNC(common,addEventHandler);

["playerInventoryChanged", {
    params ["_unit"];
    [_unit] call FUNC(takeLoadedATWeapon);
    [_unit] call FUNC(updateInventoryDisplay);
}] call EFUNC(common,addEventHandler);
