// by esteldunedain
#include "script_component.hpp"

if (!hasInterface) exitWith {};

// Add keybinds
["ACE3 Weapons", QGVAR(unjamWeapon), localize LSTRING(UnjamWeapon),
{
    // Conditions: canInteract
    if !([ACE_player, objNull, ["isNotInside"]] call EFUNC(common,canInteractWith)) exitWith {false};
    // Conditions: specific
    if !([ACE_player] call EFUNC(common,canUseWeapon) &&
    {currentWeapon ACE_player in (ACE_player getVariable [QGVAR(jammedWeapons), []])}
    ) exitWith {false};

    // Statement
    [ACE_player, currentMuzzle ACE_player, false] call FUNC(clearJam);
    true
},
{false},
[19, [true, false, false]], false] call CBA_fnc_addKeybind; //R Key
