/*
 * Author: <N/A>
 * Draws names and icons.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * call ace_nametags_fnc_onDraw3d
 *
 * Public: No
 */
#include "script_component.hpp"

private ["_onKeyPressAlphaMax", "_defaultIcon", "_distance", "_alpha", "_icon", "_targets", "_pos2", "_vecy", "_relPos", "_projDist", "_pos", "_target", "_targetEyePosASL", "_ambientBrightness", "_maxDistance"];

//don't show nametags in spectator or if RscDisplayMPInterrupt is open
if ((isNull ACE_player) || {!alive ACE_player} || {!isNull (findDisplay 49)}) exitWith {};

_ambientBrightness = ((([] call EFUNC(common,ambientBrightness)) + ([0, 0.4] select ((currentVisionMode ace_player) != 0))) min 1) max 0;
_maxDistance = _ambientBrightness * GVAR(PlayerNamesViewDistance);

_onKeyPressAlphaMax = if ((GVAR(showPlayerNames) in [3,4])) then {
    2 + (GVAR(showNamesTime) - ACE_time); //after release 1 second of full opacity, 1 second of fading to 0
} else {
    1
};

_defaultIcon = if (GVAR(showPlayerRanks)) then {
    ICON_NAME_RANK;
} else {
    ICON_NAME;
};

//When cursorTarget is on a vehicle show the nametag for the commander.
//If set to "Only On Keypress" settings, fade just like main tags
if (GVAR(showCursorTagForVehicles) && {_onKeyPressAlphaMax > 0}) then {
    _target = cursorTarget;
    if ((!(_target isKindOf "CAManBase")) && {!(_target in allUnitsUAV)}) then {
        _target = effectiveCommander _target;
        if ((!isNull _target) &&
                {(side (group _target)) == (side (group ACE_player))} &&
                {_target != ACE_player} &&
                {GVAR(showNamesForAI) || {[_target] call EFUNC(common,isPlayer)}} &&
                {!(_target getVariable ["ACE_hideName", false])}) then {
            _distance = ACE_player distance _target;
            _alpha = (((1 - 0.2 * (_distance - _maxDistance)) min 1) * GVAR(playerNamesMaxAlpha)) min _onKeyPressAlphaMax;
            [ACE_player, _target, _alpha, _distance * 0.026, _defaultIcon] call FUNC(drawNameTagIcon);
        };
    };
};

//"Only Cursor" mode, only show nametags for humans on cursorTarget
if ((GVAR(showPlayerNames) in [2,4]) && {_onKeyPressAlphaMax > 0}) then {
    _target = cursorTarget;
    if ((!isNull _target) &&
            {_target isKindOf "CAManBase"} &&
            {(side (group _target)) == (side (group ACE_player))} &&
            {_target != ACE_player} &&
            {GVAR(showNamesForAI) || {[_target] call EFUNC(common,isPlayer)}} &&
            {!(_target getVariable ["ACE_hideName", false])}) then {
        _distance = ACE_player distance _target;
        if (_distance > (_maxDistance + 5)) exitWith {};
        _alpha = (((1 - 0.2 * (_distance - _maxDistance)) min 1) * GVAR(playerNamesMaxAlpha)) min _onKeyPressAlphaMax;
        _icon = ICON_NONE;
        if (GVAR(showSoundWaves) == 2) then {  //icon will be drawn below, so only show name here
            _icon = if (([_target] call FUNC(isSpeaking)) && {(vehicle _target) == _target}) then {ICON_NAME} else {_defaultIcon};
        } else {
            _icon = if (([_target] call FUNC(isSpeaking)) && {(vehicle _target) == _target} && {GVAR(showSoundWaves) > 0}) then {ICON_NAME_SPEAK} else {_defaultIcon};
        };

        [ACE_player, _target, _alpha, _distance * 0.026, _icon] call FUNC(drawNameTagIcon);
    };
};

if (((GVAR(showPlayerNames) in [1,3]) && {_onKeyPressAlphaMax > 0}) || {GVAR(showSoundWaves) == 2}) then {
    _pos = positionCameraToWorld [0, 0, 0];
    _targets = _pos nearObjects ["CAManBase", _maxDistance + 5];

    if (!surfaceIsWater _pos) then {
        _pos = ATLtoASL _pos;
    };
    _pos2 = positionCameraToWorld [0, 0, 1];
    if (!surfaceIsWater _pos2) then {
        _pos2 = ATLtoASL _pos2;
    };
    _vecy = _pos2 vectorDiff _pos;

    {
        _target = _x;

        _icon = ICON_NONE;
        if ((GVAR(showPlayerNames) in [1,3]) && {_onKeyPressAlphaMax > 0}) then {
            if (([_target] call FUNC(isSpeaking)) && {(vehicle _target) == _target} && {GVAR(showSoundWaves) > 0}) then {_icon = ICON_NAME_SPEAK;} else {_icon = _defaultIcon};
        } else {
            //showSoundWaves must be 2, only draw speak icon
            if (([_target] call FUNC(isSpeaking)) && {(vehicle _target) == _target}) then {_icon = ICON_SPEAK;};
        };

        if ((_icon != ICON_NONE) &&
                {(side (group _target)) == (side (group ACE_player))} &&
                {_target != ACE_player} &&
                {GVAR(showNamesForAI) || {[_target] call EFUNC(common,isPlayer)}} &&
                {!(_target getVariable ["ACE_hideName", false])}) then {

            _targetEyePosASL = eyePos _target;
            if (lineIntersects [_pos, _targetEyePosASL, ACE_player, _target]) exitWith {}; // Check if there is line of sight

            _relPos = (visiblePositionASL _target) vectorDiff _pos;
            _distance = vectorMagnitude _relPos;
            _projDist = _relPos vectorDistance (_vecy vectorMultiply (_relPos vectorDotProduct _vecy));

            _alpha = (((1 - 0.2 * (_distance - _maxDistance)) min 1) * GVAR(playerNamesMaxAlpha)) min _onKeyPressAlphaMax;

            [ACE_player, _target, _alpha, _distance * 0.026, _icon] call FUNC(drawNameTagIcon);
        };
        nil
    } count _targets;
};
