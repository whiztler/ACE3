#define SIZEX (((safezoneW / safezoneH) min 1.2))
#define SIZEY (SIZEX / 1.2)
#define X_ORIGINAL(num) (num * (SIZEX / 40) + (safezoneX + (safezoneW - SIZEX)/2))
#define Y_ORIGINAL(num) (num * (SIZEY / 25) + (safezoneY + (safezoneH - (SIZEX / 1.2))/2))
#define W_ORIGINAL(num) (num * (SIZEX / 40))
#define H_ORIGINAL(num) (num * (SIZEY / 25))

#define X_MAKEITBIGGA(num) (num * (safeZoneH / 40) + (safezoneX + (safezoneW - safeZoneH)/2))
#define Y_MAKEITBIGGA(num) (num * (safeZoneH / 30) + (safezoneY + (safezoneH - (safeZoneH / 1.2))/2))
#define W_MAKEITBIGGA(num) (num * (safeZoneH / 40))
#define H_MAKEITBIGGA(num) (num * (safeZoneH / 30))

#define X_PART(num) QUOTE(linearConversion [ARR_5(0, 2, (missionNamespace getVariable [ARR_2(QUOTE(QGVAR(optionMenuDisplaySize)), 0)]), X_ORIGINAL(num), X_MAKEITBIGGA(num))])
#define Y_PART(num) QUOTE(linearConversion [ARR_5(0, 2, (missionNamespace getVariable [ARR_2(QUOTE(QGVAR(optionMenuDisplaySize)), 0)]), Y_ORIGINAL(num), Y_MAKEITBIGGA(num))])
#define W_PART(num) QUOTE(linearConversion [ARR_5(0, 2, (missionNamespace getVariable [ARR_2(QUOTE(QGVAR(optionMenuDisplaySize)), 0)]), W_ORIGINAL(num), W_MAKEITBIGGA(num))])
#define H_PART(num) QUOTE(linearConversion [ARR_5(0, 2, (missionNamespace getVariable [ARR_2(QUOTE(QGVAR(optionMenuDisplaySize)), 0)]), H_ORIGINAL(num), H_MAKEITBIGGA(num))])

class ACE_settingsMenu {
    idd = 145246;
    movingEnable = false;
    onLoad = QUOTE(uiNamespace setVariable [ARR_2('ACE_settingsMenu', _this select 0)]; [] call FUNC(onSettingsMenuOpen););
    onUnload = QUOTE(uiNamespace setVariable [ARR_2('ACE_settingsMenu', nil)]; saveProfileNamespace;);

    class controlsBackground {
        class HeaderBackground: ACE_gui_backgroundBase {
            idc = -1;
            type = CT_STATIC;
            x = X_PART(1);
            y = Y_PART(1);
            w = W_PART(38);
            h = H_PART(1);
            style = ST_LEFT + ST_SHADOW;
            font = "PuristaMedium";
            SizeEx = H_PART(1);
            colorText[] = {0.95, 0.95, 0.95, 0.75};
            colorBackground[] = {"(profilenamespace getVariable ['GUI_BCG_RGB_R',0.69])","(profilenamespace getVariable ['GUI_BCG_RGB_G',0.75])","(profilenamespace getVariable ['GUI_BCG_RGB_B',0.5])", "(profilenamespace getVariable ['GUI_BCG_RGB_A',0.9])"};
            text = "";
        };
        class CenterBackground: HeaderBackground {
            y = Y_PART(2.1);
            h = H_PART(2.5);
            text = "";
            colorText[] = {0, 0, 0, "(profilenamespace getVariable ['GUI_BCG_RGB_A',0.9])"};
            colorBackground[] = {0,0,0,"(profilenamespace getVariable ['GUI_BCG_RGB_A',0.9])"};
        };
        class LeftBackground: CenterBackground {
            y = Y_PART(4.8);
            h = H_PART(17.4);
            w = W_PART(25);
        };
        class RightBackground: LeftBackground {
            x = X_PART(26.1);
            w = W_PART(12.9);
        };
        class RightBackgroundHeader: RightBackground {
            h = H_PART(1.4);
            colorBackground[] = {0,0,0,1};
        };
    };

    class controls {
        class HeaderName {
            idc = 1;
            type = CT_STATIC;
            x = X_PART(1);
            y = Y_PART(1);
            w = W_PART(38);
            h = H_PART(1);
            style = ST_LEFT + ST_SHADOW;
            font = "PuristaMedium";
            SizeEx = H_PART(1);
            colorText[] = {0.95, 0.95, 0.95, 0.75};
            colorBackground[] = {0,0,0,0};
            text = CSTRING(OpenConfigMenu);
        };
        class labelSubHeader: ACE_gui_staticBase {
            idc = 13;
            x = X_PART(2);
            y = Y_PART(3.4);
            w = W_PART(15);
            h = H_PART(1);
            text = "";
        };
        class categorySelection: ACE_gui_comboBoxBase {
            idc = 14;
            x = X_PART(14);
            y = Y_PART(3.4);
            w = W_PART(9);
            h = H_PART(1);
            text = "";
            onLBSelChanged = QUOTE( call FUNC(onCategorySelectChanged));
            SizeEx = H_PART(0.9);
        };
        class selectionAction_1: ACE_gui_buttonBase {
            idc = 1000;
            text = CSTRING(TabOptions);
            x = X_PART(1);
            y = Y_PART(2.1);
            w = W_PART(9.5);
            h = H_PART(1);
            animTextureNormal = "#(argb,8,8,3)color(0,0,0,0.9)";
            animTextureDisabled = "#(argb,8,8,3)color(0,0,0,0.8)";
            animTextureOver = "#(argb,8,8,3)color(1,1,1,1)";
            animTextureFocused = "#(argb,8,8,3)color(1,1,1,1)";
            animTexturePressed = "#(argb,8,8,3)color(1,1,1,1)";
            animTextureDefault = "#(argb,8,8,3)color(1,1,1,1)";
            color[] = {1, 1, 1, 1};
            color2[] = {0,0,0, 1};
            colorBackgroundFocused[] = {1,1,1,1};
            colorBackground[] = {1,1,1,1};
            colorbackground2[] = {1,1,1,1};
            colorDisabled[] = {1,1,1,1};
            colorFocused[] = {0,0,0,1};
            periodFocus = 1;
            periodOver = 1;
            action = QUOTE([MENU_TAB_OPTIONS] call FUNC(onListBoxShowSelectionChanged););
            SizeEx = H_PART(1);
            Size = H_PART(1);
        };
        class selectionAction_2: selectionAction_1 {
            idc = 1001;
            text = CSTRING(TabColors);
            x = X_PART(10.5);
            action = QUOTE([MENU_TAB_COLORS] call FUNC(onListBoxShowSelectionChanged););
        };
        class selectionAction_3: selectionAction_1 {
            idc = 1002;
            text = "";
            x = X_PART(20);
            action = "";
        };
        class selectionAction_4: selectionAction_1 {
            idc = 1003;
            text = "";
            x = X_PART(29.5);
            action = "";
        };
        class listBoxSettingsList: ACE_gui_listNBox {
            idc = 200;
            x = X_PART(2);
            y = Y_PART(5.5);
            w = W_PART(23);
            h = H_PART(15);
            SizeEx = H_ORIGINAL(0.8);
            colorBackground[] = {0, 0, 0, 0.9};
            colorSelectBackground[] = {0, 0, 0, 0.9};
            columns[] = {0.0, 0.6};
            onLBSelChanged = QUOTE(_this call FUNC(settingsMenuUpdateKeyView));
        };
        class labelTitle: ACE_gui_staticBase {
            idc = 250;
            x = X_PART(27.1);
            y = Y_PART(5.1);
            w = W_PART(11);
            h = H_PART(1);
            text = "";
            SizeEx = H_PART(1);
        };
        class labelKey: ACE_gui_staticBase {  //Variable Name
            idc = 300;
            x = X_PART(27.1);
            y = Y_PART(6.2);
            w = W_PART(11);
            h = H_PART(1);
            text = "";
            SizeEx = H_PART(0.65);
        };
        class Label2: labelKey {
            idc = 301;
            y = Y_PART(7.3);
            text = CSTRING(Setting);
            SizeEx = H_PART(1);
        };
        class comboBox1: ACE_gui_comboBoxBase {
            idc = 400;
            x = X_PART(31.1);
            y = Y_PART(7.3);
            w = W_PART(7);
            h = H_PART(1);
            onLBSelChanged = QUOTE( call FUNC(onListBoxSettingsChanged));
            SizeEx = H_PART(0.9);
        };
        class sliderBar1: RscXSliderH {
            idc = 410;
            x = X_PART(27.1);
            y = Y_PART(7.3);
            w = W_PART(11);
            h = H_PART(0.75);
            onSliderPosChanged = QUOTE(_this call FUNC(onSliderPosChanged));
            color[] = {1,0,0,0.4};
            colorActive[] = {1,0,0,1};
        };
        class sliderBar2: sliderBar1 {
            idc = 411;
            y = Y_PART(8.2);
            color[] = {0,1,0,0.4};
            colorActive[] = {0,1,0,1};
        };
        class sliderBar3: sliderBar1 {
            idc = 412;
            y = Y_PART(9.1);
            color[] = {0,0,1,0.4};
            colorActive[] = {0,0,1,1};
        };
        class sliderBar4: sliderBar1 {
            idc = 413;
            y = Y_PART(10);
            color[] = {1,1,1,0.4};
            colorActive[] = {1,1,1,1};
        };
        class labelDesc: ACE_gui_staticBase {
            idc = 251;
            x = X_PART(27.1);
            y = Y_PART(11);
            w = W_PART(11);
            h = H_PART(11);
            text = "";
            style = ST_LEFT + ST_MULTI;
            lineSpacing = 1;
            SizeEx = H_PART(0.8);
        };
        class actionClose: ACE_gui_buttonBase {
            idc = 10;
            text = "$STR_DISP_CLOSE";
            x = X_PART(1);
            y = Y_PART(22.3);
            w = W_PART(7.5);
            h = H_PART(1);
            style = ST_LEFT;
            animTextureNormal = "#(argb,8,8,3)color(0,0,0,0.8)";
            animTextureDisabled = "#(argb,8,8,3)color(0,0,0,0.5)";
            animTextureOver = "#(argb,8,8,3)color(1,1,1,1)";
            animTextureFocused = "#(argb,8,8,3)color(1,1,1,1)";
            animTexturePressed = "#(argb,8,8,3)color(1,1,1,1)";
            animTextureDefault = "#(argb,8,8,3)color(1,1,1,1)";
            color[] = {1, 1, 1, 1};
            color2[] = {0,0,0, 1};
            colorBackgroundFocused[] = {1,1,1,1};
            colorBackground[] = {1,1,1,1};
            colorbackground2[] = {1,1,1,1};
            colorDisabled[] = {0.5,0.5,0.5,0.8};
            colorFocused[] = {0,0,0,1};
            periodFocus = 1;
            periodOver = 1;
            action = "closedialog 0;";
            SizeEx = H_PART(1);
            Size = H_PART(1);
        };
        class action_reset: actionClose {
            idc = 1100;
            text = CSTRING(ResetAll);
            x = X_PART(9.5);
            action = QUOTE([] call FUNC(resetSettings));
        };
        class action_exportServerConfig: actionClose {
            idc = 1102;
            text = CSTRING(OpenExport);
            x = X_PART(18);
            action = QUOTE(if (GVAR(serverConfigGeneration) > 0) then {closeDialog 0; createDialog 'ACE_serverSettingsMenu';});
        };
        class action_debug: actionClose {
            idc = 1102;
            text = CSTRING(DumpDebug);
            x = X_PART(26.1);
            action = QUOTE([] call FUNC(debugDumpToClipboard));
            tooltip = CSTRING(DumpDebugTooltip);
        };
        class action_headBugFix: actionClose {
            idc = 1102;
            text = CSTRING(headBugFix);
            x = X_PART(34);
            w = W_PART(5);
            action = QUOTE(0 spawn EFUNC(common,headBugFix); closedialog 0;);
            tooltip = CSTRING(headBugFixTooltip);
        };
    };
};
class ACE_serverSettingsMenu: ACE_settingsMenu {
    onLoad = QUOTE(uiNamespace setVariable [ARR_2('ACE_serverSettingsMenu', _this select 0)]; [] call FUNC(onServerSettingsMenuOpen););
    onUnload = QUOTE(uiNamespace setVariable [ARR_2('ACE_serverSettingsMenu', nil)];);
    class controls: controls {
        class HeaderName {
            idc = 1;
            type = CT_STATIC;
            x = X_PART(1);
            y = Y_PART(1);
            w = W_PART(38);
            h = H_PART(1);
            style = ST_LEFT + ST_SHADOW;
            font = "PuristaMedium";
            SizeEx = H_PART(1);
            colorText[] = {0.95, 0.95, 0.95, 0.75};
            colorBackground[] = {0,0,0,0};
            text = CSTRING(OpenConfigMenu);
        };
        class labelSubHeader: ACE_gui_staticBase {
            idc = 13;
            x = X_PART(2);
            y = Y_PART(3.4);
            w = W_PART(30);
            h = H_PART(1);
            text = "";
        };
        class categorySelection: ACE_gui_comboBoxBase {
            idc = 14;
            x = X_PART(14);
            y = Y_PART(3.4);
            w = W_PART(9);
            h = H_PART(1);
            text = "";
            onLBSelChanged = QUOTE( call FUNC(onServerCategorySelectChanged));
            SizeEx = H_PART(0.9);
        };
        class selectionAction_1: ACE_gui_buttonBase {
            idc = 1000;
            text = CSTRING(TabOptions);
            x = X_PART(1);
            y = Y_PART(2.1);
            w = W_PART(9.5);
            h = H_PART(1);
            animTextureNormal = "#(argb,8,8,3)color(0,0,0,0.9)";
            animTextureDisabled = "#(argb,8,8,3)color(0,0,0,0.8)";
            animTextureOver = "#(argb,8,8,3)color(1,1,1,1)";
            animTextureFocused = "#(argb,8,8,3)color(1,1,1,1)";
            animTexturePressed = "#(argb,8,8,3)color(1,1,1,1)";
            animTextureDefault = "#(argb,8,8,3)color(1,1,1,1)";
            color[] = {1, 1, 1, 1};
            color2[] = {0,0,0, 1};
            colorBackgroundFocused[] = {1,1,1,1};
            colorBackground[] = {1,1,1,1};
            colorbackground2[] = {1,1,1,1};
            colorDisabled[] = {1,1,1,1};
            colorFocused[] = {0,0,0,1};
            periodFocus = 1;
            periodOver = 1;
            action = QUOTE([MENU_TAB_SERVER_OPTIONS] call FUNC(onServerListBoxShowSelectionChanged););
        };
        class selectionAction_2: selectionAction_1 {
            idc = 1001;
            text = CSTRING(TabColors);
            x = X_PART(10.5);
            action = QUOTE([MENU_TAB_SERVER_COLORS] call FUNC(onServerListBoxShowSelectionChanged););
        };
        class selectionAction_3: selectionAction_1 {
            idc = 1002;
            text = CSTRING(TabValues);
            x = X_PART(20);
            action = QUOTE([MENU_TAB_SERVER_VALUES] call FUNC(onServerListBoxShowSelectionChanged););
        };
        class selectionAction_4: selectionAction_1 {
            idc = 1003;
            text = "";
            x = X_PART(29.5);
            action = "";
        };
        class listBoxSettingsList: ACE_gui_listNBox {
            idc = 200;
            x = X_PART(2);
            y = Y_PART(5.5);
            w = W_PART(23);
            h = H_PART(15);
            SizeEx = H_ORIGINAL(0.8);
            colorBackground[] = {0, 0, 0, 0.9};
            colorSelectBackground[] = {0, 0, 0, 0.9};
            columns[] = {0.0, 0.6};
            onLBSelChanged = QUOTE(_this call FUNC(serverSettingsMenuUpdateKeyView));
        };
        class labelTitle: ACE_gui_staticBase {
            idc = 250;
            x = X_PART(27.1);
            y = Y_PART(5.1);
            w = W_PART(11);
            h = H_PART(1);
            text = "";
            SizeEx = H_PART(1);
        };
        class labelKey: ACE_gui_staticBase {  //Variable Name
            idc = 300;
            x = X_PART(27.1);
            y = Y_PART(6.2);
            w = W_PART(11);
            h = H_PART(1);
            text = "";
            SizeEx = H_PART(0.65);
        };
        class Label2: labelKey {
            idc = 301;
            y = Y_PART(7.3);
            text = CSTRING(Setting);
            SizeEx = H_PART(1);
        };
        class comboBox1: ACE_gui_comboBoxBase {
            idc = 400;
            x = X_PART(31.1);
            y = Y_PART(7.3);
            w = W_PART(7);
            h = H_PART(1);
            onLBSelChanged = QUOTE( call FUNC(onListBoxSettingsChanged));
            SizeEx = H_PART(0.9);
        };
        class sliderBar1: RscXSliderH {
            idc = 410;
            x = X_PART(27.1);
            y = Y_PART(7.3);
            w = W_PART(11);
            h = H_PART(0.75);
            onSliderPosChanged = QUOTE(_this call FUNC(onSliderPosChanged));
            color[] = {1,0,0,0.4};
            colorActive[] = {1,0,0,1};
        };
        class sliderBar2: sliderBar1 {
            idc = 411;
            y = Y_PART(8.2);
            color[] = {0,1,0,0.4};
            colorActive[] = {0,1,0,1};
        };
        class sliderBar3: sliderBar1 {
            idc = 412;
            y = Y_PART(9.1);
            color[] = {0,0,1,0.4};
            colorActive[] = {0,0,1,1};
        };
        class sliderBar4: sliderBar1 {
            idc = 413;
            y = Y_PART(10);
            color[] = {1,1,1,0.4};
            colorActive[] = {1,1,1,1};
        };
        class inputField1: ACE_gui_editBase {
            idc = 414;
            x = X_PART(27.1);
            y = Y_PART(7.3);
            w = W_PART(11);
            h = H_PART(0.75);
        };
        class inputFieldTypeLabel: ACE_gui_staticBase {
            idc = 415;
            x = X_PART(27.1);
            y = Y_PART(8.2);
            w = W_PART(11);
            h = H_PART(0.75);
            text = "";
            style = ST_LEFT + ST_MULTI;
            lineSpacing = 1;
            SizeEx = H_PART(0.8);
        };
        class saveInputButton: selectionAction_1 {
            idc = 416;
            text = CSTRING(SaveInput);
            x = X_PART(27.1);
            y = Y_PART(9.1);
            w = W_PART(11);
            h = H_PART(1);
            action = QUOTE([] call FUNC(onServerSaveInputField););
        };
        class labelDesc: ACE_gui_staticBase {
            idc = 251;
            x = X_PART(27.1);
            y = Y_PART(11);
            w = W_PART(11);
            h = H_PART(11);
            text = "";
            style = ST_LEFT + ST_MULTI;
            lineSpacing = 1;
            SizeEx = H_PART(0.8);
        };
        class actionClose;
        class action_reset: actionClose {
            idc = 1100;
            text = CSTRING(ResetAll);
            x = X_PART(26.1);
            action = QUOTE([] call FUNC(serverResetSettings));
        };
        class action_exportServerConfig: actionClose {
            idc = 1101;
            text = CSTRING(Export);
            x = X_PART(1);
            action = QUOTE([] call FUNC(exportSettings));
        };
        class action_toggleIncludeClientSettings: actionClose {
            idc = 1102;
            text = CSTRING(inClientSettings);
            x = X_PART(9);
            action = QUOTE([] call FUNC(toggleIncludeClientSettings));
        };
    };
};
