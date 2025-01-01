---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    3d_armor/armor_crystal
-- Code:    LGPL v2.1
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.armour_boots_crystallite = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.armor_crystal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.armour_boots_crystallite.init()

    return {
        description = "Crystallite boots",
        depends = "mineral_crystallite",
    }

end

function unilib.pkg.armour_boots_crystallite.exec()

    unilib.register_armour("unilib:armour_boots_crystallite", "3d_armor:boots_crystal", mode, {
        -- From 3d_armor:boots_crystal
        description = S("Crystallite Boots"),
        inventory_image = "unilib_armour_boots_crystallite_inv.png",
        groups = {
            armour_fire = 1, armour_feet = 1, armour_heal = 12, armour_use = 100,
            physics_jump = 0.5, physics_speed = 1,
        },

        armour_groups = {fleshy = 15},
        damage_groups = {cracky = 2, level = 3, snappy = 1},
    })
    unilib.register_craft_boots({
        -- From 3d_armor:boots_crystal
        part_name = "crystallite",
        ingredient = "unilib:mineral_crystallite_ingot",
    })

end
