/*
 * Author: commy2
 * Initializes the friendly fire module.
 *
 * Arguments:
 * 0: Logic <OBJECT>
 * 1: Synced units <ARRAY>
 * 2: Activated <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [logic, [ACE_Player], true] call ace_respawn_fnc_moduleFriendlyFire
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_logic", "_units", "_activated"];

if !(_activated) exitWith {};

// this is done for JIP compatibility
if (isServer) then {
    [{
        missionNamespace setVariable [QGVAR(showFriendlyFireMessage), true];
        publicVariable QGVAR(showFriendlyFireMessage);
    },
    [], 0.1] call EFUNC(common,waitAndExecute);
};

ACE_LOGINFO("Friendly Fire Messages Module Initialized.");
