
class CfgVehicles {
    class Man;
    class CAManBase: Man {
        class ACE_SelfActions {
            class ACE_Equipment {
                class GVAR(place) {
                    displayName = CSTRING(Placedown);
                    condition = QUOTE([ARR_2(_player,'ACE_SpottingScope')] call EFUNC(common,hasItem));
                    statement = QUOTE([ARR_2(_player,'ACE_SpottingScope')] call FUNC(place));
                    showDisabled = 0;
                    priority = 2;
                    icon = PATHTOF(UI\w_spottingscope_ca.paa);
                };
            };
        };
    };

    class Item_Base_F;
    class ACE_Item_SpottingScope: Item_Base_F {
        author[] = {"Rocko", "Scubaman3D"};
        scope = 2;
        scopeCurator = 2;
        displayName = CSTRING(DisplayName);
        vehicleClass = "Items";
        class TransportItems {
            MACRO_ADDITEM(ACE_SpottingScope,1);
        };
    };

    class Box_NATO_Support_F;
    class ACE_Box_Misc: Box_NATO_Support_F {
        class TransportItems {
            MACRO_ADDITEM(ACE_Item_SpottingScope,2);
        };
    };

    class LandVehicle;
    class StaticWeapon: LandVehicle {
        class Turrets;
        class ACE_Actions {
            class ACE_MainActions {};
        };
    };
    class StaticATWeapon: StaticWeapon {
        class Turrets: Turrets {
            class MainTurret;
        };
        class ACE_Actions: ACE_Actions{
            class ACE_MainActions: ACE_MainActions {};
        };
    };
    class ACE_SpottingScopeObject: StaticATWeapon {
        XEH_ENABLED;
        scope = 1;
        side = 1;
        typicalCargo[] = {"Soldier"};
        displayName = CSTRING(DisplayName);
        model = PATHTOF(data\ace_spottingscope.p3d);
        mapSize = 0.5;
        transportSoldier = 0;
        getInAction = "GetInLow";
        getOutAction = "GetOutLow";
        class Turrets: Turrets {
            class MainTurret: MainTurret {
                minTurn = -45;
                maxTurn = 45;
                initTurn = 0;
                minElev = -10;
                maxElev = 40;
                initElev = 0;

                weapons[] = {};
                magazines[] = {};
                gunnerOpticsColor[] = {1,1,1,1};
                gunnerOpticsmodel = PATHTOF(data\m144_optic.p3d);
                gunnerOpticsEffect[] = {"OpticsCHAbera1","OpticsBlur2"};
                gunnerOutOpticsShowCursor = 0;
                gunnerOpticsShowCursor = 0;
                gunnerAction = "ACE_SpottingScope";
                gunnerGetInAction = "GetInLow";
                gunnerGetOutAction = "GetOutLow";
                gunnerForceOptics = 0;
                ejectDeadGunner = 0;
                class ViewGunner {
                    initAngleX = 5;
                    minAngleX = -30;
                    maxAngleX = 30;
                    initAngleY = 0;
                    minAngleY = -100;
                    maxAngleY = 100;
                    initFov = 0.75;
                    minFov = 0.25;
                    maxFov = 1.25;
                };
                class ViewOptics {
                    initAngleX = 0;
                    minAngleX = -30;
                    maxAngleX = 30;
                    initAngleY = 0;
                    minAngleY = -100;
                    maxAngleY = 100;
                    minFov = 0.0025;
                    maxFov = 0.05;
                    initFov= 0.05;
                };
            };
        };
        EGVAR(dragging,canDrag) = 1;
        EGVAR(dragging,dragPosition[]) = {0,1,0};
        EGVAR(dragging,dragDirection) = 0;
        class ACE_Actions: ACE_Actions{
            class ACE_MainActions: ACE_MainActions {
                selection = "osaveze";
                class ACE_Pickup {
                    selection = "";
                    displayName = CSTRING(PickUp);
                    distance = 5;
                    condition = QUOTE((alive _target) && (count (crew _target) == 0));
                    statement = QUOTE([ARR_2(_target,_player)] call FUNC(pickup));
                    showDisabled = 0;
                    exceptions[] = {};
                    priority = 5;
                    icon = PATHTOF(UI\w_spottingscope_ca.paa);
                };
            };
        };
    };
};
