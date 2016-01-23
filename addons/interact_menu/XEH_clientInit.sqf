//XEH_clientInit.sqf
#include "script_component.hpp"

if (!hasInterface) exitWith {};

GVAR(cachedBuildingTypes) = [];
GVAR(cachedBuildingActionPairs) = [];

GVAR(ParsedTextCached) = [];

["SettingChanged", {
    params ["_name"];
    if (({_x == _name} count [QGVAR(colorTextMax), QGVAR(colorTextMin), QGVAR(colorShadowMax), QGVAR(colorShadowMin), QGVAR(textSize), QGVAR(shadowSetting)]) == 1) then {
        [] call FUNC(setupTextColors);
    };
}] call EFUNC(common,addEventhandler);

["SettingsInitialized", {
    //Setup text/shadow/size/color settings matrix
    [] call FUNC(setupTextColors);
    // Install the render EH on the main display
    addMissionEventHandler ["Draw3D", DFUNC(render)];
}] call EFUNC(common,addEventHandler);

//Add Actions to Houses:
["interactMenuOpened", {_this call FUNC(userActions_addHouseActions)}] call EFUNC(common,addEventHandler);

// This spawn is probably worth keeping, as pfh don't work natively on the briefing screen and IDK how reliable the hack we implemented for them is.
// The thread dies as soon as the mission start, so it's not really compiting for scheduler space.
[] spawn {
    // Wait until the map display is detected
    waitUntil {(!isNull findDisplay 12)};

    // Install the render EH on the map screen
    ((findDisplay 12) displayCtrl 51) ctrlAddEventHandler ["Draw", DFUNC(render)];
};


["ACE3 Common", QGVAR(InteractKey), (localize LSTRING(InteractKey)),
{
    // Statement
    [0] call FUNC(keyDown)
},{[0,false] call FUNC(keyUp)},
[219, [false, false, false]], false] call CBA_fnc_addKeybind;  //Left Windows Key

["ACE3 Common", QGVAR(SelfInteractKey), (localize LSTRING(SelfInteractKey)),
{
    // Statement
    [1] call FUNC(keyDown)
},{[1,false] call FUNC(keyUp)},
[219, [false, true, false]], false] call CBA_fnc_addKeybind; //Left Windows Key + Ctrl/Strg


// Listens for the falling unconscious event, just in case the menu needs to be closed
["medical_onUnconscious", {
    // If no menu is open just quit
    if (GVAR(openedMenuType) < 0) exitWith {};

    params ["_unit", "_isUnconscious"];

    if (_unit != ACE_player || !_isUnconscious) exitWith {};

    GVAR(actionSelected) = false;
    [GVAR(openedMenuType), false] call FUNC(keyUp);
}] call EFUNC(common,addEventhandler);

// disable firing while the interact menu is is is opened
["playerChanged", {_this call FUNC(handlePlayerChanged)}] call EFUNC(common,addEventHandler);

// background options
["interactMenuOpened", {
    if (GVAR(menuBackground)==1) then {[QGVAR(menuBackground), true] call EFUNC(common,blurScreen);};
    if (GVAR(menuBackground)==2) then {0 cutRsc[QGVAR(menuBackground), "PLAIN", 1, false];};
}] call EFUNC(common,addEventHandler);
["interactMenuClosed", {
    if (GVAR(menuBackground)==1) then {[QGVAR(menuBackground), false] call EFUNC(common,blurScreen);};
    if (GVAR(menuBackground)==2) then {(uiNamespace getVariable [QGVAR(menuBackground), displayNull]) closeDisplay 0;};
}] call EFUNC(common,addEventHandler);

//Debug to help end users identify mods that break CBA's XEH
[{
    private _badClassnames = [];
    {
        //Only check Land objects (WeaponHolderSimulated show up in `vehicles` for some reason)
        if ((_x isKindOf "Land") && {(isNil (format [QGVAR(Act_%1), typeOf _x])) || {isNil (format [QGVAR(SelfAct_%1), typeOf _x])}}) then {
            if (!((typeOf _x) in _badClassnames)) then {
                _badClassnames pushBack (typeOf _x);
                ACE_LOGERROR_3("Compile checks bad for (classname: %1)(addon: %2) %3", (typeOf _x), (unitAddons (typeOf _x)), _x);
            };
        };
    } forEach (allUnits + allDeadMen + vehicles);
    if ((count _badClassnames) == 0) then {
        ACE_LOGINFO("All compile checks passed");
    } else {
        ACE_LOGERROR_1("%1 Classnames failed compile check!!! (bad XEH / missing cba_enable_auto_xeh.pbo)", (count _badClassnames));

        //Only show visual error if they are actually missing the pbo:
        #define SUPMON configFile>>"CfgSettings">>"CBA">>"XEH">>"supportMonitor"
        if ((!isNumber(SUPMON)) || {getNumber(SUPMON) != 1}) then {
            ["ACE Interaction failed to compile for some units (try adding cba_enable_auto_xeh.pbo)"] call BIS_fnc_error;
        };
    };
}, [], 5] call EFUNC(common,waitAndExecute);  //ensure CBASupMon has time to run first
