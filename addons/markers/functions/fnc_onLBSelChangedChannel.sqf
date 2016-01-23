/*
 * Author: commy2
 * When the channel list box is changed.
 *
 * Arguments:
 * 0: Channel ListBox (idc 103) <CONTROL>
 * 1: Selected Index <NUMBER>
 *
 * Return Value:
 * None
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_ctrl", "_index"];
TRACE_2("params",_ctrl,_index);

private _channelName = _ctrl lbText _index;

setCurrentChannel (CHANNEL_NAMES find _channelName);
