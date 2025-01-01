---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    technic_armor
-- Code:    LGPL v2.1
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.armour_boots_brass = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.technic_armor.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.armour_boots_brass.init()

    return {
        description = "Brass boots",
        depends = "metal_brass",
    }

end

function unilib.pkg.armour_boots_brass.exec()

    unilib.register_armour("unilib:armour_boots_brass", "technic_armor:boots_brass", mode, {
        -- From technic_armor:boots_brass
        description = S("Brass Boots"),
        inventory_image = "unilib_armour_boots_brass_inv.png",
        groups = {armour_feet = 7, armour_heal = 0, armour_radiation = 4, armour_use = 650},
    })
    unilib.register_craft_boots({
        -- From technic_armor:boots_brass
        part_name = "brass",
        ingredient = "unilib:metal_brass_ingot",
    })

end
