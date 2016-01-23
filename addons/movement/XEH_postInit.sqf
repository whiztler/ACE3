//by commy2
#include "script_component.hpp"

if (!hasInterface) exitWith {};

["inventoryDisplayLoaded", {

    [{
        disableSerialization;
        params ["_dialog"];

        if (isNull _dialog) exitWith {
            [_this select 1] call CBA_fnc_removePerFrameHandler;
        };

        _dialog displayCtrl 111 ctrlSetText format ["%1 - %2 %3", [ACE_player, false, true] call EFUNC(common,getName), localize LSTRING(Weight), [ACE_player] call FUNC(getWeight)];

    }, 0, _this select 0] call CBA_fnc_addPerFrameHandler;

}] call EFUNC(common,addEventHandler);

["ACE3 Movement", QGVAR(climb), localize LSTRING(Climb),
{
    // Conditions: canInteract
    if !([ACE_player, objNull, []] call EFUNC(common,canInteractWith)) exitWith {false};
    // Conditions: specific
    if (ACE_player != (vehicle ACE_player)) exitWith {false};

    // Statement
    [ACE_player] call FUNC(climb);
    true
},
{false},
[47, [false, true, false]], false] call CBA_fnc_addKeybind; //DIK_V + CTRL//STRG
