#define MACRO_REPAIRVEHICLE \
    class ACE_Actions { \
        class ACE_MainActions { \
            class GVAR(Repair) { \
                displayName = CSTRING(Repair); \
                condition = "true"; \
                statement = ""; \
                runOnHover = 1; \
                showDisabled = 0; \
                priority = 2; \
                icon = "\A3\ui_f\data\igui\cfg\actions\repair_ca.paa"; \
                distance = 4; \
                exceptions[] = {"isNotOnLadder"}; \
            }; \
        }; \
    };

class CfgVehicles {
    class ACE_Module;
    class ACE_moduleRepairSettings: ACE_Module {
        scope = 2;
        displayName = CSTRING(moduleName);
        icon = QUOTE(PATHTOF(ui\Icon_Module_Repair_ca.paa));
        category = "ACE_Logistics";
        function = QFUNC(moduleRepairSettings);
        functionPriority = 1;
        isGlobal = 1;
        isSingular = 1;
        isTriggerActivated = 0;
        author = ECSTRING(Common,ACETeam);
        class Arguments {
            class engineerSetting_Repair {
                displayName = CSTRING(enginerSetting_Repair_name);
                description = CSTRING(enginerSetting_Repair_description);
                typeName = "NUMBER";
                class values {
                    class anyone { name = CSTRING(engineerSetting_anyone); value = 0; };
                    class Engineer { name = CSTRING(engineerSetting_EngineerOnly); value = 1; default = 1; };
                    class Special { name = CSTRING(engineerSetting_RepairSpecialistOnly); value = 2; };
                };
            };
            class engineerSetting_Wheel {
                displayName = CSTRING(enginerSetting_Wheel_name);
                description = CSTRING(enginerSetting_Wheel_description);
                typeName = "NUMBER";
                class values {
                    class anyone { name = CSTRING(engineerSetting_anyone); value = 0; default = 1; };
                    class Engineer { name = CSTRING(engineerSetting_EngineerOnly); value = 1; };
                    class Special { name = CSTRING(engineerSetting_RepairSpecialistOnly); value = 2; };
                };
            };
            class repairDamageThreshold {
                displayName = CSTRING(repairDamageThreshold_name);
                description = CSTRING(repairDamageThreshold_description);
                typeName = "NUMBER";
                defaultValue = 0.6;
            };
            class repairDamageThreshold_Engineer {
                displayName = CSTRING(repairDamageThreshold_Engineer_name);
                description = CSTRING(repairDamageThreshold_Engineer_description);
                typeName = "NUMBER";
                defaultValue = 0.4;
            };
            class consumeItem_ToolKit {
                displayName = CSTRING(consumeItem_ToolKit_name);
                description = CSTRING(consumeItem_ToolKit_description);
                typeName = "NUMBER";
                class values {
                    class keep { name = ECSTRING(common,No); value = 0; default = 1; };
                    class remove { name = ECSTRING(common,Yes); value = 1; };
                };
            };
            class fullRepairLocation {
                displayName = CSTRING(fullRepairLocation);
                description = CSTRING(fullRepairLocation_description);
                typeName = "NUMBER";
                class values {
                    class anywhere { name = CSTRING(useAnywhere); value = 0; };
                    class vehicle { name = CSTRING(repairVehicleOnly); value = 1; };
                    class facility { name = CSTRING(repairFacilityOnly); value = 2; default = 1; };
                    class vehicleAndFacility { name = CSTRING(vehicleAndFacility); value = 3; };
                    class disabled { name = ECSTRING(common,Disabled); value = 4;};
                };
            };
            class engineerSetting_fullRepair {
                displayName = CSTRING(engineerSetting_fullRepair_name);
                description = CSTRING(engineerSetting_fullRepair_description);
                typeName = "NUMBER";
                class values {
                    class anyone { name = CSTRING(engineerSetting_anyone); value = 0; };
                    class Engineer { name = CSTRING(engineerSetting_EngineerOnly); value = 1; };
                    class Special { name = CSTRING(engineerSetting_RepairSpecialistOnly); value = 2; default = 1;};
                };
            };
            class addSpareParts {
                displayName = CSTRING(addSpareParts_name);
                description = CSTRING(addSpareParts_description);
                typeName = "BOOL";
                defaultValue = 1;
            };
            class wheelRepairRequiredItems {
                displayName = CSTRING(wheelRepairRequiredItems_name);
                description = CSTRING(wheelRepairRequiredItems_description);
                typeName = "NUMBER";
                class values {
                    class None { name = "None"; value = 0;  default = 1;};
                    class ToolKit { name = "ToolKit"; value = 1; };
                };
            };
        };
        class ModuleDescription {
            description = CSTRING(moduleDescription);
            sync[] = {};
        };
    };

    class Module_F;
    class ACE_moduleAssignEngineerRoles: Module_F {
        scope = 2;
        displayName = CSTRING(AssignEngineerRole_Module_DisplayName);
        icon = QUOTE(PATHTOF(ui\Icon_Module_Repair_ca.paa));
        category = "ACE_Logistics";
        function = QFUNC(moduleAssignEngineer);
        functionPriority = 10;
        isGlobal = 2;
        isTriggerActivated = 0;
        isDisposable = 0;
        author = ECSTRING(common,ACETeam);
        class Arguments {
            class EnableList {
                displayName = CSTRING(EnableList_DisplayName);
                description = CSTRING(AssignEngineerRole_EnableList_Description);
                defaultValue = "";
                typeName = "STRING";
            };
            class role {
                displayName = CSTRING(AssignEngineerRole_role_DisplayName);
                description = CSTRING(AssignEngineerRole_role_Description);
                typeName = "NUMBER";
                class values {
                    class none {
                        name = CSTRING(AssignEngineerRole_role_none);
                        value = 0;
                    };
                    class medic {
                        name = CSTRING(AssignEngineerRole_role_engineer);
                        value = 1;
                        default = 1;
                    };
                    class doctor {
                        name = CSTRING(AssignEngineerRole_role_specialist);
                        value = 2;
                    };
                };
            };
        };
        class ModuleDescription {
            description = CSTRING(AssignEngineerRole_Module_Description);
            sync[] = {};
        };
    };
    class ACE_moduleAssignRepairVehicle: Module_F {
        scope = 2;
        displayName = CSTRING(AssignRepairVehicle_Module_DisplayName);
        icon = QUOTE(PATHTOF(ui\Icon_Module_Repair_ca.paa));
        category = "ACE_Logistics";
        function = QFUNC(moduleAssignRepairVehicle);
        functionPriority = 10;
        isGlobal = 2;
        isTriggerActivated = 0;
        isDisposable = 0;
        author = ECSTRING(common,ACETeam);
        class Arguments {
            class EnableList {
                displayName = CSTRING(EnableList_DisplayName);
                description = CSTRING(AssignRepairVehicle_EnableList_Description);
                defaultValue = "";
                typeName = "STRING";
            };
            class role {
                displayName = CSTRING(AssignRepairVehicle_role_DisplayName);
                description = CSTRING(AssignRepairVehicle_role_Description);
                typeName = "NUMBER";
                class values {
                    class none {
                        name = ECSTRING(common,No);
                        value = 0;
                    };
                    class isVehicle {
                        name = ECSTRING(common,Yes);
                        value = 1;
                        default = 1;
                    };
                };
            };
        };
        class ModuleDescription {
            description = CSTRING(AssignRepairVehicle_Module_Description);
            sync[] = {};
        };
    };
    class ACE_moduleAssignRepairFacility: ACE_moduleAssignRepairVehicle {
        displayName = CSTRING(AssignRepairFacility_Module_DisplayName);
        function = QFUNC(moduleAssignRepairFacility);
        class Arguments {
            class EnableList {
                displayName = CSTRING(EnableList_DisplayName);
                description = CSTRING(AssignRepairFacility_EnableList_Description);
                defaultValue = "";
                typeName = "STRING";
            };
            class role {
                displayName = CSTRING(AssignRepairFacility_role_DisplayName);
                description = CSTRING(AssignRepairFacility_role_Description);
                typeName = "NUMBER";
                class values {
                    class none {
                        name = ECSTRING(common,No);
                        value = 0;
                    };
                    class isFacility {
                        name = ECSTRING(common,Yes);
                        value = 1;
                        default = 1;
                    };
                };
            };
        };
        class ModuleDescription {
            description = CSTRING(AssignRepairFacility_Module_Description);
            sync[] = {};
        };
    };
    class ACE_moduleAddSpareParts: Module_F {
        scope = 2;
        displayName = CSTRING(AddSpareParts_Module_DisplayName);
        icon = QUOTE(PATHTOF(ui\Icon_Module_Repair_ca.paa));
        category = "ACE_Logistics";
        function = QFUNC(moduleAddSpareParts);
        functionPriority = 10;
        isGlobal = 0;
        isTriggerActivated = 0;
        isDisposable = 0;
        author = ECSTRING(common,ACETeam);
        class Arguments {
            class List {
                displayName = CSTRING(EnableList_DisplayName);
                description = CSTRING(AddSpareParts_List_Description);
                defaultValue = "";
                typeName = "STRING";
            };
            class Part {
                displayName = CSTRING(AddSpareParts_Part_DisplayName);
                description = CSTRING(AddSpareParts_Part_Description);
                typeName = "STRING";
                class values {
                    class Wheel {
                        name = CSTRING(SpareWheel);
                        value = "ACE_Wheel";
                        default = 1;
                    };
                    class Track {
                        name = CSTRING(SpareTrack);
                        value = "ACE_Track";
                    };
                };
            };
            class Amount {
                displayName = CSTRING(AddSpareParts_Amount_DisplayName);
                description = CSTRING(AddSpareParts_Amount_Description);
                typeName = "NUMBER";
                defaultValue = 1;
            };
        };
        class ModuleDescription {
            description = CSTRING(AddSpareParts_Module_Description);
            sync[] = {};
        };
    };


    class LandVehicle;
    class Car: LandVehicle {
        MACRO_REPAIRVEHICLE
    };

    class Tank: LandVehicle {
        MACRO_REPAIRVEHICLE
    };

    class Air;
    class Helicopter: Air {
        MACRO_REPAIRVEHICLE
    };

    class Plane: Air {
        MACRO_REPAIRVEHICLE
    };

    class Ship;
    class Ship_F: Ship {
        MACRO_REPAIRVEHICLE
    };

    class ThingX;
    class ACE_RepairItem_Base: ThingX {
        XEH_ENABLED;
        icon = "iconObject_circle";
        mapSize = 0.7;
        accuracy = 0.2;
        vehicleClass = "ACE_Logistics_Items";
        destrType = "DesturctNo";
    };

    class ACE_Track: ACE_RepairItem_Base {
        EGVAR(cargo,size) = 2;
        EGVAR(cargo,canLoad) = 1;
        author = "Hawkins";
        scope = 2;
        model = QUOTE(PATHTOF(data\ace_track.p3d));
        displayName = CSTRING(SpareTrack);
    };

    class ACE_Wheel: ACE_RepairItem_Base {
        EGVAR(cargo,size) = 1;
        EGVAR(cargo,canLoad) = 1;
        author = "Hawkins";
        scope = 2;
        model = QUOTE(PATHTOF(data\ace_wheel.p3d));
        displayName = CSTRING(SpareWheel);
        picture = QUOTE(PATHTOF(ui\tire_ca.paa));
    };

    // disable vanilla repair
    // "getNumber (_x >> ""transportRepair"") > 0" configClasses (configFile >> "CfgVehicles")

    class Slingload_01_Base_F;
    class B_Slingload_01_Repair_F: Slingload_01_Base_F {
        GVAR(canRepair) = 1;
        transportRepair = 0;
    };

    class Helicopter_Base_H;
    class Heli_Transport_04_base_F: Helicopter_Base_H {
        GVAR(hitpointGroups[]) = { {"HitEngine", {"HitEngine1", "HitEngine2"}}, {"Glass_1_hitpoint", {"Glass_2_hitpoint", "Glass_3_hitpoint", "Glass_4_hitpoint", "Glass_5_hitpoint", "Glass_6_hitpoint", "Glass_7_hitpoint", "Glass_8_hitpoint", "Glass_9_hitpoint", "Glass_10_hitpoint", "Glass_11_hitpoint", "Glass_12_hitpoint", "Glass_13_hitpoint", "Glass_14_hitpoint", "Glass_15_hitpoint", "Glass_16_hitpoint", "Glass_17_hitpoint", "Glass_18_hitpoint", "Glass_19_hitpoint", "Glass_20_hitpoint"}} };
    };
    class O_Heli_Transport_04_repair_F: Heli_Transport_04_base_F {
        GVAR(canRepair) = 1;
        transportRepair = 0;
    };

    class Pod_Heli_Transport_04_base_F;
    class Land_Pod_Heli_Transport_04_repair_F: Pod_Heli_Transport_04_base_F {
        GVAR(canRepair) = 1;
        transportRepair = 0;
    };

    class Heli_Transport_02_base_F;
    class I_Heli_Transport_02_F: Heli_Transport_02_base_F {
        GVAR(hitpointPositions[]) = {{"HitVRotor", {-1,-9.4,1.8}}, {"HitHRotor", {0,1.8,1.3}}};
    };

    class Helicopter_Base_F;
    class Heli_light_03_base_F: Helicopter_Base_F {
        GVAR(hitpointPositions[]) = {{"HitVRotor", {-0.5,-5.55,1.2}}, {"HitHRotor", {0,1.8,1.5}}};
    };

    class B_APC_Tracked_01_base_F;
    class B_APC_Tracked_01_CRV_F: B_APC_Tracked_01_base_F {
        GVAR(canRepair) = 1;
        transportRepair = 0;
    };

    class B_APC_Tracked_01_AA_F: B_APC_Tracked_01_base_F {
        GVAR(hitpointPositions[]) = {{"HitTurret", {0,-2,0}}};
    };

    class Car_F;
    class Offroad_01_base_F: Car_F {
        GVAR(hitpointGroups[]) = { {"HitGlass1", {"HitGlass2"}} };
    };
    class Offroad_01_repair_base_F: Offroad_01_base_F {
        GVAR(canRepair) = 1;
        transportRepair = 0;
    };

    class MRAP_01_base_F: Car_F {
        GVAR(hitpointGroups[]) = { {"HitGlass1", {"HitGlass2", "HitGlass3", "HitGlass4", "HitGlass5", "HitGlass6"}} };
    };

    class B_Truck_01_mover_F;
    class B_Truck_01_Repair_F: B_Truck_01_mover_F {
        GVAR(canRepair) = 1;
        transportRepair = 0;
    };

    class B_Truck_01_fuel_F: B_Truck_01_mover_F {  // the fuel hemet apparently can repair. GJ BI
        transportRepair = 0;
    };

    class Truck_02_base_F;
    class Truck_02_box_base_F: Truck_02_base_F {
        GVAR(canRepair) = 1;
        transportRepair = 0;
    };

    class Truck_02_engineeral_base_F: Truck_02_box_base_F {
        GVAR(canRepair) = 0;
    };

    class Truck_03_base_F;
    class O_Truck_03_repair_F: Truck_03_base_F {
        GVAR(canRepair) = 1;
        transportRepair = 0;
    };

    class Quadbike_01_base_F;
    class B_Quadbike_01_F: Quadbike_01_base_F {
        GVAR(hitpointPositions[]) = { {"HitEngine", {0, 0.5, -0.7}}, {"HitFuel", {0, 0, -0.5}} };
    };
    class Hatchback_01_base_F: Car_F {
        GVAR(hitpointPositions[]) = {{"HitBody", {0, 0.7, -0.5}}, {"HitFuel", {0, -1.75, -0.75}}};
    };
};
