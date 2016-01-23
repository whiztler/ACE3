class CfgWeapons {
    class ACE_ItemCore;
    class InventoryItem_Base_F;

    class ACE_MapTools: ACE_ItemCore {
        displayName = CSTRING(Name);
        descriptionShort = CSTRING(Description);
        model = QUOTE(PATHTOF(data\ace_MapTools.p3d));
        picture = PATHTOF(UI\maptool_item.paa);
        scope = 2;
        class ItemInfo: InventoryItem_Base_F {
            mass = 1;
        };
    };
};
