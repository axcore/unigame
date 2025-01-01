---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    3d_armor/armor_bronze
-- Code:    LGPL v2.1
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.armour_leggings_bronze = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.armor_bronze.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.armour_leggings_bronze.init()

    return {
        description = "Bronze leggings",
        depends = "metal_bronze",
    }

end

function unilib.pkg.armour_leggings_bronze.exec()

    unilib.register_armour("unilib:armour_leggings_bronze", "3d_armor:leggings_bronze", mode, {
        -- From 3d_armor:leggings_bronze
        description = S("Bronze Leggings"),
        inventory_image = "unilib_armour_leggings_bronze_inv.png",
        groups = {
            armour_heal = 6, armour_legs = 1, armour_use = 400, physics_gravity = 0.03,
            physics_speed = -0.03,
        },

        armour_groups = {fleshy = 15},
        damage_groups = {choppy = 2, cracky = 3, crumbly = 1, level = 2, snappy = 2},
    })
    unilib.register_craft_leggings({
        -- From 3d_armor:leggings_bronze
        part_name = "bronze",
        ingredient = "unilib:metal_bronze_ingot",
    })

end
