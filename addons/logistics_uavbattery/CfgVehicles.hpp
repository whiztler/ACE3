class CfgVehicles {
    class Air;
    class Helicopter: Air {
        class ACE_Actions {
            class ACE_MainActions {};
        };
    };
    class Helicopter_Base_F: Helicopter {
        class ACE_Actions: ACE_Actions{
            class ACE_MainActions: ACE_MainActions {};
        };
    };
    class UAV_01_base_F: Helicopter_Base_F {
        class ACE_Actions: ACE_Actions{
            class ACE_MainActions: ACE_MainActions {
                class GVAR(RefuelUAV) {
                    displayName = CSTRING(Recharge);
                    distance = 4;
                    condition = QUOTE([ARR_2(_player, _target)] call FUNC(canRefuelUAV));
                    statement = QUOTE([ARR_2(_player, _target)] call FUNC(refuelUAV));
                    showDisabled = 0;
                    priority = 1.245;
                    icon = QUOTE(PATHTOF(ui\UAV_battery_ca.paa));
                };
            };
        };
    };

    // Misc box content
    class Box_NATO_Support_F;
    class ACE_Box_Misc: Box_NATO_Support_F {
        class TransportItems {
            MACRO_ADDITEM(ACE_UAVBattery,6);
        };
    };
};
