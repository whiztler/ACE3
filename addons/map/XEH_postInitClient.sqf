#include "script_component.hpp"

//Delete map glow lights from disconnecting players #2810
if (isServer) then {
    addMissionEventHandler ["HandleDisconnect",{
        params ["_disconnectedPlayer"];

        if ((!GVAR(mapGlow)) || {isNull _disconnectedPlayer}) exitWith {};
        {
            if (_x isKindOf "ACE_FlashlightProxy_White") then {
                // ACE_LOGINFO_2("Deleting leftover light [%1:%2] from DC player [%3]", _x, typeOf _x, _disconnectedPlayer);
                deleteVehicle _x;
            };
        } forEach attachedObjects _disconnectedPlayer;
        
        nil
    }];
};

// Exit on Headless as well
if (!hasInterface) exitWith {};

LOG(MSG_INIT);

// Calculate the maximum zoom allowed for this map
call FUNC(determineZoom);

[{
    if (isNull findDisplay 12) exitWith {};

    GVAR(lastStillPosition) = ((findDisplay 12) displayCtrl 51) ctrlMapScreenToWorld [0.5, 0.5];
    GVAR(lastStillTime) = ACE_time;
    GVAR(isShaking) = false;

    //map sizes are multiples of 1280
    GVAR(worldSize) = worldSize / 1280;
    GVAR(mousePos) = [0.5,0.5];

    //Allow panning the lastStillPosition while mapShake is active
    GVAR(rightMouseButtonLastPos) = [];
    ((findDisplay 12) displayCtrl 51) ctrlAddEventHandler ["Draw", {[] call FUNC(updateMapEffects);}];
    ((findDisplay 12) displayCtrl 51) ctrlAddEventHandler ["MouseMoving", {
        if (GVAR(isShaking) && {(count GVAR(rightMouseButtonLastPos)) == 2}) then {
            private["_lastPos", "_newPos"];
            _lastPos = (_this select 0) ctrlMapScreenToWorld GVAR(rightMouseButtonLastPos);
            _newPos = (_this select 0) ctrlMapScreenToWorld (_this select [1,2]);
            GVAR(lastStillPosition) set [0, (GVAR(lastStillPosition) select 0) + (_lastPos select 0) - (_newPos select 0)];
            GVAR(lastStillPosition) set [1, (GVAR(lastStillPosition) select 1) + (_lastPos select 1) - (_newPos select 1)];
            GVAR(rightMouseButtonLastPos) = _this select [1,2];
            TRACE_3("Mouse Move",_lastPos,_newPos,GVAR(rightMouseButtonLastPos));
        };
    }];
    ((findDisplay 12) displayCtrl 51) ctrlAddEventHandler ["MouseButtonDown", {
        if ((_this select 1) == 1) then {
            GVAR(rightMouseButtonLastPos) = _this select [2,2];
        };
    }];
    ((findDisplay 12) displayCtrl 51) ctrlAddEventHandler ["MouseButtonUp", {
        if ((_this select 1) == 1) then {
            GVAR(rightMouseButtonLastPos) = [];
        };
    }];

    //get mouse position on map
    ((findDisplay 12) displayCtrl 51) ctrlAddEventHandler ["MouseMoving", {
        GVAR(mousePos) = (_this select 0) ctrlMapScreenToWorld [_this select 1, _this select 2];
    }];
    ((findDisplay 12) displayCtrl 51) ctrlAddEventHandler ["MouseHolding", {
        GVAR(mousePos) = (_this select 0) ctrlMapScreenToWorld [_this select 1, _this select 2];
    }];

    [_this select 1] call CBA_fnc_removePerFrameHandler;
}, 0] call CBA_fnc_addPerFrameHandler;

["SettingsInitialized", {
    if (isMultiplayer && {GVAR(DefaultChannel) != -1}) then {
        //Set the chat channel once the map has finished loading
        [{
            if ((isNull findDisplay 37) && {isNull findDisplay 52} && {isNull findDisplay 53} && {isNull findDisplay 12}) exitWith {};
            [_this select 1] call CBA_fnc_removePerFrameHandler;

            setCurrentChannel GVAR(DefaultChannel);
            if (currentChannel == GVAR(DefaultChannel)) then {
                // ACE_LOGINFO_1("Channel Set - %1", currentChannel);
            } else {
                ACE_LOGERROR_2("Failed To Set Channel %1 (is %2)", GVAR(DefaultChannel), currentChannel);
            };
        }, 0, []] call CBA_fnc_addPerFrameHandler;
    };

    // Start Blue Force Tracking if Enabled
    if (GVAR(BFT_Enabled)) then {
        GVAR(BFT_markers) = [];
        [FUNC(blueForceTrackingUpdate), GVAR(BFT_Interval), []] call CBA_fnc_addPerFrameHandler;
    };

    //illumination settings
    if (GVAR(mapIllumination)) then {
        GVAR(flashlightInUse) = "";
        GVAR(glow) = objNull;

        ["playerInventoryChanged", {
            private _flashlights = [ACE_player] call FUNC(getUnitFlashlights);
            if ((GVAR(flashlightInUse) != "") && !(GVAR(flashlightInUse) in _flashlights)) then {
                GVAR(flashlightInUse) = "";
            };
        }] call EFUNC(common,addEventHandler);

        if (GVAR(mapGlow)) then {
            ["visibleMapChanged", {
                params ["_player", "_mapOn"];
                if (_mapOn) then {
                    if (!alive _player && !isNull GVAR(glow)) then {
                        GVAR(flashlightInUse) = "";
                    };
                    if (GVAR(flashlightInUse) != "") then {
                        if (isNull GVAR(glow)) then {
                            [GVAR(flashlightInUse)] call FUNC(flashlightGlow);
                        };
                    } else {
                        if (!isNull GVAR(glow)) then {
                            [""] call FUNC(flashlightGlow);
                        };
                    };
                } else {
                    if (!isNull GVAR(glow)) then {
                        [""] call FUNC(flashlightGlow);
                    };
                };
            }] call EFUNC(common,addEventHandler);
        };
    };
}] call EFUNC(common,addEventHandler);

// hide clock on map if player has no watch
GVAR(hasWatch) = true;

["playerInventoryChanged", {
    if (isNull (_this select 0)) exitWith {
        GVAR(hasWatch) = true;
    };
    GVAR(hasWatch) = false;
    {
        if (_x isKindOf ["ItemWatch", configFile >> "CfgWeapons"]) exitWith {GVAR(hasWatch) = true;};
        false
    } count (assignedItems ACE_player);
}] call EFUNC(common,addEventHandler);
