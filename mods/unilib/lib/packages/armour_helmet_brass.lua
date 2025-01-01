---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    technic_armor
-- Code:    LGPL v2.1
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.armour_helmet_brass = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.technic_armor.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.armour_helmet_brass.init()

    return {
        description = "Brass helmet",
        depends = "metal_brass",
    }

end

function unilib.pkg.armour_helmet_brass.exec()

    unilib.register_armour("unilib:armour_helmet_brass", "technic_armor:helmet_brass", mode, {
        -- From technic_armor:helmet_brass
        description = S("Brass Helmet"),
        inventory_image = "unilib_armour_helmet_brass_inv.png",
        groups = {armour_head = 9, armour_heal = 0, armour_radiation = 4, armour_use = 650},
    })
    unilib.register_craft_helmet({
        -- From technic_armor:helmet_brass
        part_name = "brass",
        ingredient = "unilib:metal_brass_ingot",
    })

end
