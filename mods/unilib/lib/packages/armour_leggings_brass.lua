---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    technic_armor
-- Code:    LGPL v2.1
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.armour_leggings_brass = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.technic_armor.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.armour_leggings_brass.init()

    return {
        description = "Brass leggings",
        depends = "metal_brass",
    }

end

function unilib.pkg.armour_leggings_brass.exec()

    unilib.register_armour("unilib:armour_leggings_brass", "technic_armor:leggings_brass", mode, {
        -- From technic_armor:leggings_brass
        description = S("Brass Leggings"),
        inventory_image = "unilib_armour_leggings_brass_inv.png",
        groups = {armour_heal = 0, armour_legs = 12, armour_radiation = 6, armour_use = 650},
    })
    unilib.register_craft_leggings({
        -- From technic_armor:leggings_brass
        part_name = "brass",
        ingredient = "unilib:metal_brass_ingot",
    })

end
