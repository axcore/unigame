---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    3d_armor/armor_nether
-- Code:    LGPL v2.1
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.armour_helmet_nether = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.armor_nether.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.armour_helmet_nether.init()

    return {
        description = "Nether helmet",
        mod_depends = "nether",
    }

end

function unilib.pkg.armour_helmet_nether.exec()

    unilib.register_armour("unilib:armour_helmet_nether", "3d_armor:helmet_nether", mode, {
        -- From 3d_armor:helmet_nether
        description = S("Nether Helmet"),
        inventory_image = "unilib_armour_helmet_nether_inv.png",
        groups = {armour_fire = 1, armour_head = 1, armour_heal = 14, armour_use = 100},

        armour_groups = {fleshy = 18},
        damage_groups = {cracky = 3, level = 3, snappy = 2},
    })
    unilib.register_craft_helmet({
        -- From 3d_armor:helmet_nether
        part_name = "nether",
        ingredient = "nether:nether_ingot",
    })

end
