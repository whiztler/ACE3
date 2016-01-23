
class Extended_PreInit_EventHandlers {
    class ADDON {
        init = QUOTE(call COMPILE_FILE(XEH_preInit));
    };
};

class Extended_PostInit_EventHandlers {
    class ADDON {
        init = QUOTE(call COMPILE_FILE(XEH_postInit));
    };
};

class Extended_Init_EventHandlers {
    class Tank {
        class ADDON {
            serverInit = QUOTE(_this call FUNC(vehicleInit));
        };
    };
    class Car {
        class ADDON {
            serverInit = QUOTE(_this call FUNC(vehicleInit));
        };
    };
    class Helicopter {
        class ADDON {
            serverInit = QUOTE(_this call FUNC(vehicleInit));
        };
    };
    class Plane {
        class ADDON {
            serverInit = QUOTE(_this call FUNC(vehicleInit));
        };
    };
    class Ship_F {
        class ADDON {
            serverInit = QUOTE(_this call FUNC(vehicleInit));
        };
    };
    class StaticWeapon {
        class ADDON {
            serverInit = QUOTE(_this call FUNC(vehicleInit));
        };
    };
};

class Extended_Respawn_EventHandlers {
    class Tank {
        class ADDON {
            respawn = QUOTE(_this call FUNC(vehicleInit));
        };
    };
    class Car {
        class ADDON {
            respawn = QUOTE(_this call FUNC(vehicleInit));
        };
    };
    class Helicopter {
        class ADDON {
            respawn = QUOTE(_this call FUNC(vehicleInit));
        };
    };
    class Plane {
        class ADDON {
            respawn = QUOTE(_this call FUNC(vehicleInit));
        };
    };
    class Ship_F {
        class ADDON {
            respawn = QUOTE(_this call FUNC(vehicleInit));
        };
    };
    class StaticWeapon {
        class ADDON {
            respawn = QUOTE(_this call FUNC(vehicleInit));
        };
    };
};

class Extended_FiredBIS_EventHandlers {
    class Tank {
        class ADDON {
            firedBIS = QUOTE(_this call FUNC(firedEH));
        };
    };
    class Car {
        class ADDON {
            firedBIS = QUOTE(_this call FUNC(firedEH));
        };
    };
    class Helicopter {
        class ADDON {
            firedBIS = QUOTE(_this call FUNC(firedEH));
        };
    };
    class Plane {
        class ADDON {
            firedBIS = QUOTE(_this call FUNC(firedEH));
        };
    };
    class Ship_F {
        class ADDON {
            firedBIS = QUOTE(_this call FUNC(firedEH));
        };
    };
    class StaticWeapon {
        class ADDON {
            firedBIS = QUOTE(_this call FUNC(firedEH));
        };
    };
};
