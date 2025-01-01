---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    3d_armor/armor_nether
-- Code:    LGPL v2.1
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.armour_leggings_nether = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.armor_nether.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.armour_leggings_nether.init()

    return {
        description = "Nether leggings",
        mod_depends = "nether",
    }

end

function unilib.pkg.armour_leggings_nether.exec()

    unilib.register_armour("unilib:armour_leggings_nether", "3d_armor:leggings_nether", mode, {
        -- From 3d_armor:leggings_nether
        description = S("Nether Leggings"),
        inventory_image = "unilib_armour_leggings_nether_inv.png",
        groups = {armour_fire = 1, armour_heal = 14, armour_legs = 1, armour_use = 200},

        armour_groups = {fleshy = 25},
        damage_groups = {cracky = 3, level = 3, snappy = 2},
    })
    unilib.register_craft_leggings({
        -- From 3d_armor:leggings_nether
        part_name = "nether",
        ingredient = "nether:nether_ingot",
    })

end
