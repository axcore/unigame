---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    3d_armor_gloves
-- Code:    LGPL v2.1
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.armour_gauntlets_crystallite = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table["3d_armor_gloves"].add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.armour_gauntlets_crystallite.init()

    return {
        description = "Crystallite gauntlets",
        depends = {"item_string_ordinary", "mineral_crystallite"},
    }

end

function unilib.pkg.armour_gauntlets_crystallite.exec()

    unilib.register_armour(
        -- From 3d_armor_gloves:gloves_crystal
        "unilib:armour_gauntlets_crystallite",
        "3d_armor_gloves:gloves_crystal",
        mode,
        {
            description = S("Crystallite Gauntlets"),
            inventory_image = "unilib_armour_gauntlets_crystallite_inv.png",
            groups = {
                armour_fire = 1, armour_hands = 1, armour_heal = 12, armour_use = 100,
                physics_jump = 0.5, physics_speed = 1,
            },

            armour_groups = {fleshy = 15},
            damage_groups = {cracky = 2, level = 3, snappy = 1},
        }
    )
    unilib.register_craft_gauntlets({
        -- From 3d_armor_gloves:gloves_crystal
        part_name = "crystallite",
        ingredient = "unilib:mineral_crystallite_ingot",
        minor_ingredient = "unilib:item_string_ordinary",
    })

end
