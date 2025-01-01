---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    3d_armor_gloves
-- Code:    LGPL v2.1
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.armour_gauntlets_steel = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table["3d_armor_gloves"].add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.armour_gauntlets_steel.init()

    return {
        description = "Steel gauntlets",
        depends = {"item_string_ordinary", "metal_steel"},
    }

end

function unilib.pkg.armour_gauntlets_steel.exec()

    unilib.register_armour("unilib:armour_gauntlets_steel", "3d_armor_gloves:gloves_steel", mode, {
        -- From 3d_armor_gloves:gloves_steel
        description = S("Steel Gauntlets"),
        inventory_image = "unilib_armour_gauntlets_steel_inv.png",
        groups = {
            armour_hands = 1, armour_heal = 0, armour_use = 800, physics_gravity = 0.01,
            physics_speed = -0.01,
        },

        armour_groups = {fleshy = 10},
        damage_groups = {choppy = 2, cracky = 2, crumbly = 1, level = 2, snappy = 3},
    })
    unilib.register_craft_gauntlets({
        -- From 3d_armor_gloves:gloves_steel
        part_name = "steel",
        ingredient = "unilib:metal_steel_ingot",
        minor_ingredient = "unilib:item_string_ordinary",
    })

end
