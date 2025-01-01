---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    3d_armor_gloves
-- Code:    LGPL v2.1
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.armour_gauntlets_bronze = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table["3d_armor_gloves"].add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.armour_gauntlets_bronze.init()

    return {
        description = "Bronze gauntlets",
        depends = {"item_string_ordinary", "metal_bronze"},
    }

end

function unilib.pkg.armour_gauntlets_bronze.exec()

    unilib.register_armour(
        -- From 3d_armor_gloves:gloves_bronze
        "unilib:armour_gauntlets_bronze",
        "3d_armor_gloves:gloves_bronze",
        mode,
        {
            description = S("Bronze Gauntlets"),
            inventory_image = "unilib_armour_gauntlets_bronze_inv.png",
            groups = {
                armour_hands = 1, armour_heal = 6, armour_use = 400, physics_gravity = 0.01,
                physics_speed = -0.01,
            },

            armour_groups = {fleshy = 10},
            damage_groups = {choppy = 2, cracky = 3, crumbly = 1, level = 2, snappy = 2},
        }
    )
    unilib.register_craft_gauntlets({
        -- From 3d_armor_gloves:gloves_bronze
        part_name = "bronze",
        ingredient = "unilib:metal_bronze_ingot",
        minor_ingredient = "unilib:item_string_ordinary",
    })

end
