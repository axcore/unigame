---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    3d_armor/armor_cactus
-- Code:    LGPL v2.1
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.armour_helmet_cactus = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.armor_cactus.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.armour_helmet_cactus.init()

    return {
        description = "Cactus helmet",
        depends = "plant_cactus_ordinary",
    }

end

function unilib.pkg.armour_helmet_cactus.exec()

    unilib.register_armour("unilib:armour_helmet_cactus", "3d_armor:helmet_cactus", mode, {
        -- From 3d_armor:helmet_cactus
        description = S("Cactus Helmet"),
        inventory_image = "unilib_armour_helmet_cactus_inv.png",
        groups = {armour_head = 1, armour_heal = 0, armour_use = 1000},

        armour_groups = {fleshy = 5},
        damage_groups = {choppy = 2, cracky = 3, crumbly = 2, level = 1, snappy = 3},
    })
    unilib.register_craft_helmet({
        -- From 3d_armor:helmet_cactus
        part_name = "cactus",
        ingredient = "unilib:plant_cactus_ordinary",
    })
    unilib.register_craft({
        -- From 3d_armor:helmet_cactus
        type = "fuel",
        recipe = "unilib:armour_helmet_cactus",
        burntime = 14,
    })

end
