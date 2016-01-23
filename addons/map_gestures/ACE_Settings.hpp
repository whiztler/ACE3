class ACE_Settings {
    class GVAR(enabled) {
        displayName = CSTRING(enabled_displayName);
        description = CSTRING(enabled_description);
        category = CSTRING(mapGestures_category);
        typeName = "BOOL";
        value = 1;
    };
    class GVAR(maxRange) {
        displayName = CSTRING(maxRange_displayName);
        description = CSTRING(maxRange_description);
        category = CSTRING(mapGestures_category);
        typeName = "SCALAR";
        value = 7;
    };
    class GVAR(interval) {
        displayName = CSTRING(interval_displayName);
        description = CSTRING(interval_description);
        category = CSTRING(mapGestures_category);
        typeName = "SCALAR";
        value = 0.03;
    };
    class GVAR(nameTextColor) {
        displayName = CSTRING(nameTextColor_displayName);
        description = CSTRING(nameTextColor_description);
        category = CSTRING(mapGestures_category);
        isClientSettable = 1;
        typeName = "COLOR";
        value[] = {0.2, 0.2, 0.2, 0.3};
    };
    class GVAR(defaultLeadColor) {
        displayName = CSTRING(defaultLeadColor_displayName);
        description = CSTRING(defaultLeadColor_description);
        category = CSTRING(mapGestures_category);
        isClientSettable = 1;
        typeName = "COLOR";
        value[] = {1, 0.88, 0, 0.95};
    };
    class GVAR(defaultColor) {
        displayName = CSTRING(defaultColor_displayName);
        description = CSTRING(defaultColor_description);
        category = CSTRING(mapGestures_category);
        isClientSettable = 1;
        typeName = "COLOR";
        value[] = {1, 0.88, 0, 0.7};
    };
    class GVAR(GroupColorConfigurations) {
        displayName = CSTRING(GroupColorConfigurations_displayName);
        description = CSTRING(GroupColorConfigurations_description);
        category = CSTRING(mapGestures_category);
        typeName = "ARRAY";
        value[] = {};
    };
    class GVAR(GroupColorConfigurationMapping) {
        displayName = CSTRING(GroupColorConfigurationMapping_displayName);
        description = CSTRING(GroupColorConfigurationMapping_description);
        category = CSTRING(mapGestures_category);
        typeName = "ARRAY";
        value[] = {{}, {}};
    };
};
