---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    3d_armor/armor_steel
-- Code:    LGPL v2.1
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.armour_boots_steel = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.armor_steel.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.armour_boots_steel.init()

    return {
        description = "Steel boots",
        depends = "metal_steel",
    }

end

function unilib.pkg.armour_boots_steel.exec()

    unilib.register_armour("unilib:armour_boots_steel", "3d_armor:boots_steel", mode, {
        -- From 3d_armor:boots_steel
        description = S("Steel Boots"),
        inventory_image = "unilib_armour_boots_steel_inv.png",
        groups = {
            armour_feet = 1, armour_heal = 0, armour_use = 800, physics_gravity = 0.01,
            physics_speed = -0.01,
        },

        armour_groups = {fleshy = 10},
        damage_groups = {choppy = 2, cracky = 2, crumbly = 1, level = 2, snappy = 3},
    })
    unilib.register_craft_boots({
        -- From 3d_armor:boots_steel
        part_name = "steel",
        ingredient = "unilib:metal_steel_ingot",
    })

end
