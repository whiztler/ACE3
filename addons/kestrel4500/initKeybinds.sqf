["ACE3 Equipment", QGVAR(KestrelDialogKey), localize LSTRING(KestrelDialogKey),
{
    // Conditions: canInteract
    if !([ACE_player, objNull, ["notOnMap", "isNotInside", "isNotSitting"]] call EFUNC(common,canInteractWith)) exitWith {false};
    if (GVAR(Kestrel4500)) exitWith {
        closeDialog 0;
        false
    };    
    // Statement
    [] call FUNC(createKestrelDialog);
    false
},
{false},
[0, [false, false, false]], false, 0] call CBA_fnc_addKeybind; // (empty default key)

["ACE3 Equipment", QGVAR(DisplayKestrelKey), localize LSTRING(DisplayKestrelKey),
{
    // Conditions: canInteract
    if !([ACE_player, objNull, ["notOnMap", "isNotInside", "isNotSitting"]] call EFUNC(common,canInteractWith)) exitWith {false};
    
    // Statement
    [] call FUNC(displayKestrel);
    false
},
{false},
[0, [true, false, false]], false, 0] call CBA_fnc_addKeybind; // (empty default key)


//Add deviceKey entry:
private ["_conditonCode", "_toggleCode", "_closeCode"];
_conditonCode = {
    [] call FUNC(canShow);
};
_toggleCode = {
    // Conditions: canInteract
    if !([ACE_player, objNull, []] call EFUNC(common,canInteractWith)) exitWith {};
    
    // Statement
    if (!GVAR(Overlay)) then {
        //If no overlay, show it:
        [] call FUNC(displayKestrel);
    } else {
        //If overlay is up, switch to dialog:
        [] call FUNC(createKestrelDialog);
    };
};
_closeCode = {
    // Statement
    if (GVAR(Overlay)) then {
        //If dispaly is open, close it:
        GVAR(Overlay) = false;
    };
    if (dialog && {!isNull (uiNamespace getVariable ["Kestrel4500_Display", displayNull])}) then {
        //If dialog is open, close it:
        GVAR(Kestrel4500) = false;
        closeDialog 0;
    };
};
[(localize LSTRING(Name)), QUOTE(PATHTOF(UI\Kestrel4500.paa)), _conditonCode, _toggleCode, _closeCode] call EFUNC(common,deviceKeyRegisterNew);
