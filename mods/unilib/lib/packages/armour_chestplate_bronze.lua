---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    3d_armor/armor_bronze
-- Code:    LGPL v2.1
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.armour_chestplate_bronze = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.armor_bronze.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.armour_chestplate_bronze.init()

    return {
        description = "Bronze chestplate",
        depends = "metal_bronze",
    }

end

function unilib.pkg.armour_chestplate_bronze.exec()

    unilib.register_armour("unilib:armour_chestplate_bronze", "3d_armor:chestplate_bronze", mode, {
        -- From 3d_armor:chestplate_bronze
        description = S("Bronze Chestplate"),
        inventory_image = "unilib_armour_chestplate_bronze_inv.png",
        groups = {
            armour_heal = 6, armour_torso = 1, armour_use = 400, physics_gravity = 0.04,
            physics_speed = -0.04,
        },

        armour_groups = {fleshy = 15},
        damage_groups = {choppy = 2, cracky = 3, crumbly = 1, level = 2, snappy = 2},
    })
    unilib.register_craft_chestplate({
        -- From 3d_armor:chestplate_bronze
        part_name = "bronze",
        ingredient = "unilib:metal_bronze_ingot",
    })

end
