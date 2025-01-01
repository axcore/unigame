---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    3d_armor/armor_steel
-- Code:    LGPL v2.1
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.armour_chestplate_steel = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.armor_steel.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.armour_chestplate_steel.init()

    return {
        description = "Steel chestplate",
        depends = "metal_steel",
    }

end

function unilib.pkg.armour_chestplate_steel.exec()

    unilib.register_armour("unilib:armour_chestplate_steel", "3d_armor:chestplate_steel", mode, {
        -- From 3d_armor:chestplate_steel
        description = S("Steel Chestplate"),
        inventory_image = "unilib_armour_chestplate_steel_inv.png",
        groups = {
            armour_heal = 0, armour_torso = 1, armour_use = 800, physics_gravity = 0.04,
            physics_speed = -0.04,
        },

        armour_groups = {fleshy = 15},
        damage_groups = {choppy = 2, cracky = 2, crumbly = 1, level = 2, snappy = 3},
    })
    unilib.register_craft_chestplate({
        -- From 3d_armor:chestplate_steel
        part_name = "steel",
        ingredient = "unilib:metal_steel_ingot",
    })

end
