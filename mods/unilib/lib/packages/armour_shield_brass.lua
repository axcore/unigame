---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    technic_armor
-- Code:    LGPL v2.1
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.armour_shield_brass = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.technic_armor.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.armour_shield_brass.init()

    return {
        description = "Brass shield",
        depends = "metal_brass",
    }

end

function unilib.pkg.armour_shield_brass.exec()

    unilib.register_armour("unilib:armour_shield_brass", "technic_armor:shield_brass", mode, {
        -- From technic_armor:shield_brass
        description = S("Brass Shield"),
        inventory_image = "unilib_armour_shield_brass_inv.png",
        groups = {armour_heal = 0, armour_radiation = 0, armour_shield = 9, armour_use = 650},
    })
    unilib.register_craft_shield({
        -- From technic_armor:shield_brass
        part_name = "brass",
        ingredient = "unilib:metal_brass_ingot",
    })

end
