class ACE_Settings {
    class GVAR(DisplayTextOnRepair) {
        displayName = CSTRING(SettingDisplayTextName);
        description = CSTRING(SettingDisplayTextDesc);
        typeName = "BOOL";
        isClientSettable = 1;
        value = 1;
        category = ECSTRING(OptionsMenu,CategoryLogistics);
    };
    class GVAR(engineerSetting_Repair) {
        displayName = CSTRING(enginerSetting_Repair_name);
        description = CSTRING(enginerSetting_Repair_description);
        typeName = "SCALAR";
        value = 1;
        values[] = {CSTRING(engineerSetting_anyone), CSTRING(engineerSetting_EngineerOnly), CSTRING(engineerSetting_RepairSpecialistOnly)};
        category = ECSTRING(OptionsMenu,CategoryLogistics);
    };
    class GVAR(engineerSetting_Wheel) {
        displayName = CSTRING(enginerSetting_Wheel_name);
        description = CSTRING(enginerSetting_Wheel_description);
        typeName = "SCALAR";
        value = 0;
        values[] = {CSTRING(engineerSetting_anyone), CSTRING(engineerSetting_EngineerOnly), CSTRING(engineerSetting_RepairSpecialistOnly)};
        category = ECSTRING(OptionsMenu,CategoryLogistics);
    };
    class GVAR(repairDamageThreshold) {
        displayName = CSTRING(repairDamageThreshold_name);
        description = CSTRING(repairDamageThreshold_description);
        typeName = "SCALAR";
        value = 0.6;
        category = ECSTRING(OptionsMenu,CategoryLogistics);
    };
    class GVAR(repairDamageThreshold_Engineer) {
        displayName = CSTRING(repairDamageThreshold_Engineer_name);
        description = CSTRING(repairDamageThreshold_Engineer_description);
        typeName = "SCALAR";
        value = 0.4;
        category = ECSTRING(OptionsMenu,CategoryLogistics);
    };
    class GVAR(consumeItem_ToolKit) {
        displayName = CSTRING(consumeItem_ToolKit_name);
        description = CSTRING(consumeItem_ToolKit_description);
        typeName = "SCALAR";
        value = 0;
        values[] = {ECSTRING(common,No), ECSTRING(common,Yes)};
        category = ECSTRING(OptionsMenu,CategoryLogistics);
    };
    class GVAR(fullRepairLocation) {
        displayName = CSTRING(fullRepairLocation);
        description = CSTRING(fullRepairLocation_description);
        typeName = "SCALAR";
        value = 2;
        values[] = {CSTRING(useAnywhere), CSTRING(repairVehicleOnly), CSTRING(repairFacilityOnly), CSTRING(vehicleAndFacility), ECSTRING(common,Disabled)};
        category = ECSTRING(OptionsMenu,CategoryLogistics);
    };
    class GVAR(engineerSetting_fullRepair) {
        displayName = CSTRING(engineerSetting_fullRepair_name);
        description = CSTRING(engineerSetting_fullRepair_description);
        typeName = "SCALAR";
        value = 2;
        values[] = {CSTRING(engineerSetting_anyone), CSTRING(engineerSetting_EngineerOnly), CSTRING(engineerSetting_RepairSpecialistOnly)};
        category = ECSTRING(OptionsMenu,CategoryLogistics);
    };
    class GVAR(addSpareParts) {
        displayName = CSTRING(addSpareParts_name);
        description = CSTRING(addSpareParts_description);
        typeName = "BOOL";
        value = 1;
        category = ECSTRING(OptionsMenu,CategoryLogistics);
    };
    class GVAR(wheelRepairRequiredItems) {
        displayName = CSTRING(wheelRepairRequiredItems_name);
        description = CSTRING(wheelRepairRequiredItems_description);
        category = ECSTRING(OptionsMenu,CategoryLogistics);
        typeName = "SCALAR";
        value = 0;
        values[] = {"None", "ToolKit"};
        _values[] = {{}, {"ToolKit"}};
    };
};
