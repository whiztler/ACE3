/*
 * Author: commy2
 * Return enabled channels.
 *
 * Arguments:
 * 0: false - use channel id, true - use localized channel names <BOOl> (default: false)
 *
 * Return Value:
 * Enabled Channels <ARRAY>
 *
 * Public: No
 */
#include "script_component.hpp"

params [["_localize", false, [false]]];

private _currentChannel = currentChannel;
private _enabledChannels = [];

if (_localize) then {
    if (setCurrentChannel 0) then {
        _enabledChannels pushBack localize "str_channel_global";
    };

    if (setCurrentChannel 1) then {
        _enabledChannels pushBack localize "str_channel_side";
    };

    if (setCurrentChannel 2) then {
        _enabledChannels pushBack localize "str_channel_command";
    };

    if (setCurrentChannel 3) then {
        _enabledChannels pushBack localize "str_channel_group";
    };

    if (setCurrentChannel 4) then {
        _enabledChannels pushBack localize "str_channel_vehicle";
    };

    if (setCurrentChannel 5) then {
        _enabledChannels pushBack localize "str_channel_direct";
    };
} else {
    for "_i" from 0 to 5 do {
        if (setCurrentChannel _i) then {
            _enabledChannels pushBack _i;
        };
    };
};

setCurrentChannel _currentChannel;

_enabledChannels
