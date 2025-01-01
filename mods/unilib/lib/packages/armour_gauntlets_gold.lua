---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    3d_armor_gloves
-- Code:    LGPL v2.1
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.armour_gauntlets_gold = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table["3d_armor_gloves"].add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.armour_gauntlets_gold.init()

    return {
        description = "Gold gauntlets",
        depends = {"item_string_ordinary", "metal_gold"},
    }

end

function unilib.pkg.armour_gauntlets_gold.exec()

    unilib.register_armour("unilib:armour_gauntlets_gold", "3d_armor_gloves:gloves_gold", mode, {
        -- From 3d_armor_gloves:gloves_gold
        description = S("Gold Gauntlets"),
        inventory_image = "unilib_armour_gauntlets_gold_inv.png",
        groups = {
            armour_hands = 1, armour_heal = 6, armour_use = 300, physics_gravity = 0.02,
            physics_speed = -0.02,
        },

        armour_groups = {fleshy = 10},
        damage_groups = {choppy = 2, cracky = 1, crumbly = 3, level = 2, snappy = 2},
    })
    unilib.register_craft_gauntlets({
        -- From 3d_armor_gloves:gloves_gold
        part_name = "gold",
        ingredient = "unilib:metal_gold_ingot",
        minor_ingredient = "unilib:item_string_ordinary",
    })

end
