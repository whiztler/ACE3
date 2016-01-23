class CfgVehicles {
    class All {
        ACE_NightVision_grain = 0.75;
        ACE_NightVision_blur = 0.055;
    };

    class Box_NATO_Support_F;
    class ACE_Box_Misc: Box_NATO_Support_F {
        class TransportItems {
            MACRO_ADDITEM(ACE_NVG_Gen1,6);
            MACRO_ADDITEM(ACE_NVG_Gen2,6);
            //MACRO_ADDITEM(ACE_NVG_Gen3,6);
            MACRO_ADDITEM(ACE_NVG_Gen4,6);
            MACRO_ADDITEM(ACE_NVG_Wide,6);
        };
    };

    class ACE_Module;
    class GVAR(ModuleSettings): ACE_Module {
        scope = 2;
        displayName = CSTRING(Module_DisplayName);
        icon = QUOTE(PATHTOF(UI\Icon_Module_ca.paa));
        category = "ACE";
        function = QUOTE(FUNC(initModule));
        functionPriority = 1;
        isGlobal = 1;
        isTriggerActivated = 0;
        author = "BaerMitUmlaut";
        class Arguments {
            class disableNVGsWithSights {
                displayName = CSTRING(DisableNVGsWithSights_DisplayName);
                description = CSTRING(DisableNVGsWithSights_Description);
                typeName = "BOOL";
                defaultValue = 1;
            };
        };
        class ModuleDescription {
            description = CSTRING(Module_Description);
        };
    };
};
