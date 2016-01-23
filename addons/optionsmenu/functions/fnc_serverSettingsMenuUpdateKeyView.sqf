/*
 * Author: Glowbal
 * Updates the right half of the option menu for the currently selected option.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call ACE_optionsmenu_fnc_settingsMenuUpdateKeyView
 *
 * Public: No
 */

#include "script_component.hpp"

private ["_settingsMenu", "_collection", "_settingIndex", "_setting", "_entryName", "_localizedName", "_localizedDescription", "_possibleValues", "_settingsValue", "_currentColor", "_expectedType"];
disableSerialization;

_settingsMenu = uiNamespace getVariable 'ACE_serverSettingsMenu';

_collection = switch (GVAR(optionMenu_openTab)) do {
    case MENU_TAB_SERVER_OPTIONS: {GVAR(serverSideOptions)};
    case MENU_TAB_SERVER_COLORS: {GVAR(serverSideColors)};
    case MENU_TAB_SERVER_VALUES: {GVAR(serverSideValues)};
    default {[]};
};

_settingIndex = -1;
if (((lnbCurSelRow 200) >= 0) && {(lnbCurSelRow 200) < ((lnbSize 200) select 0)}) then {
    _settingIndex =  lnbValue [200, [(lnbCurSelRow 200), 0]];
};

if ((_settingIndex >= 0) && {_settingIndex <= (count _collection)}) then {
    _setting = _collection select _settingIndex;

    _entryName = _setting select 0;
    _localizedName = _setting select 3;
    _localizedDescription = _setting select 4;

    if (_localizedName == "") then {_localizedName = _entryName;};
    (_settingsMenu displayCtrl 250) ctrlSetText _localizedName;
    (_settingsMenu displayCtrl 251) ctrlSetText _localizedDescription;
    (_settingsMenu displayCtrl 300) ctrlSetText _entryName;

    switch (GVAR(optionMenu_openTab)) do {
        case (MENU_TAB_SERVER_OPTIONS): {
            _possibleValues = _setting select 5;
            _settingsValue = _setting select 9;
            // Created disable/enable options for bools
            if ((_setting select 1) == "BOOL") then {
                lbClear 400;
                lbAdd [400, (localize ELSTRING(common,No))];
                lbAdd [400, (localize ELSTRING(common,Yes))];
                _settingsValue = [0, 1] select _settingsValue;
            } else {
                lbClear 400;
                { lbAdd [400, _x]; } forEach _possibleValues;
            };
            (_settingsMenu displayCtrl 400) lbSetCurSel _settingsValue;
        };
        case (MENU_TAB_SERVER_COLORS): {
            _currentColor = _setting select 9;
            {
                sliderSetPosition [_x, (255 * (_currentColor select _forEachIndex))];
            } forEach [410, 411, 412, 413];
        };
        case (MENU_TAB_SERVER_VALUES): {
            // TODO implement
            _settingsValue = _setting select 9;

            // Created disable/enable options for bools
            _expectedType = switch (_setting select 1) do {
                case "STRING": {LSTRING(stringType)};
                case "ARRAY": {LSTRING(arrayType)};
                case "SCALAR": {LSTRING(scalarType)};
                default {LSTRING(unknownType)};
            };
            (_settingsMenu displayCtrl 414) ctrlSetText format["%1", _settingsValue];
            (_settingsMenu displayCtrl 415) ctrlSetText format[localize _expectedType];
        };
    };
} else {  //no settings in list:
    lbClear 400;
    (_settingsMenu displayCtrl 250) ctrlSetText "No settings available";
    (_settingsMenu displayCtrl 251) ctrlSetText "No settings available";
    (_settingsMenu displayCtrl 300) ctrlSetText "No settings available";
};
