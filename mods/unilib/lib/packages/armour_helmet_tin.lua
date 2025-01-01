---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    technic_armor
-- Code:    LGPL v2.1
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.armour_helmet_tin = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.technic_armor.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.armour_helmet_tin.init()

    return {
        description = "Tin helmet",
        depends = "metal_tin",
    }

end

function unilib.pkg.armour_helmet_tin.exec()

    unilib.register_armour("unilib:armour_helmet_tin", "technic_armor:helmet_tin", mode, {
        -- From technic_armor:helmet_tin
        description = S("Tin Helmet"),
        inventory_image = "unilib_armour_helmet_tin_inv.png",
        groups = {armour_head = 8, armour_heal = 0, armour_radiation = 3, armour_use = 750},
    })
    unilib.register_craft_helmet({
        -- From technic_armor:helmet_tin
        part_name = "tin",
        ingredient = "unilib:metal_tin_ingot",
    })

end
