---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    3d_armor/armor_gold
-- Code:    LGPL v2.1
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.armour_leggings_gold = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.armor_gold.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.armour_leggings_gold.init()

    return {
        description = "Gold leggings",
        depends = "metal_gold",
    }

end

function unilib.pkg.armour_leggings_gold.exec()

    unilib.register_armour("unilib:armour_leggings_gold", "3d_armor:leggings_gold", mode, {
        -- From 3d_armor:leggings_gold
        description = S("Gold Leggings"),
        inventory_image = "unilib_armour_leggings_gold_inv.png",
        groups = {
            armour_heal = 6, armour_legs = 1, armour_use = 300, physics_gravity = 0.04,
            physics_speed = -0.04,
        },

        armour_groups = {fleshy = 15},
        damage_groups = {choppy = 2, cracky = 1, crumbly = 3, level = 2, snappy = 2},
    })
    unilib.register_craft_leggings({
        -- From 3d_armor:leggings_gold
        part_name = "gold",
        ingredient = "unilib:metal_gold_ingot",
    })

end
