---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    3d_armor_gloves
-- Code:    LGPL v2.1
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.armour_gauntlets_mithril = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table["3d_armor_gloves"].add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.armour_gauntlets_mithril.init()

    return {
        description = "Mithril gauntlets",
        depends = {"item_string_ordinary", "metal_mithril"},
    }

end

function unilib.pkg.armour_gauntlets_mithril.exec()

    unilib.register_armour(
        -- From 3d_armor_gloves:gloves_mithril
        "unilib:armour_gauntlets_mithril",
        "3d_armor_gloves:gloves_mithril",
        mode,
        {
            description = S("Mithril Gauntlets"),
            inventory_image = "unilib_armour_gauntlets_mithril_inv.png",
            groups = {armour_hands = 1, armour_heal = 12, armour_use = 100},

            armour_groups = {fleshy = 15},
            damage_groups = {cracky = 2, level = 3, snappy = 1},
        }
    )
    unilib.register_craft_gauntlets({
        -- From 3d_armor_gloves:gloves_mithril
        part_name = "mithril",
        ingredient = "unilib:metal_mithril_ingot",
        minor_ingredient = "unilib:item_string_ordinary",
    })

end
