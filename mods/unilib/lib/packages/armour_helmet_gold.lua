---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    3d_armor/armor_gold
-- Code:    LGPL v2.1
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.armour_helmet_gold = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.armor_gold.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.armour_helmet_gold.init()

    return {
        description = "Gold helmet",
        depends = "metal_gold",
    }

end

function unilib.pkg.armour_helmet_gold.exec()

    unilib.register_armour("unilib:armour_helmet_gold", "3d_armor:helmet_gold", mode, {
        -- From 3d_armor:helmet_gold
        description = S("Gold Helmet"),
        inventory_image = "unilib_armour_helmet_gold_inv.png",
        groups = {
            armour_head = 1, armour_heal = 6, armour_use = 300, physics_gravity = 0.02,
            physics_speed = -0.02,
        },

        armour_groups = {fleshy = 10},
        damage_groups = {choppy = 2, cracky = 1, crumbly = 3, level = 2, snappy = 2},
    })
    unilib.register_craft_helmet({
        -- From 3d_armor:helmet_gold
        part_name = "gold",
        ingredient = "unilib:metal_gold_ingot",
    })

end
