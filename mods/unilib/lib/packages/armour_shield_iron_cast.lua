---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    technic_armor
-- Code:    LGPL v2.1
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.armour_shield_iron_cast = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.technic_armor.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.armour_shield_iron_cast.init()

    return {
        description = "Cast iron shield",
        depends = "metal_iron_cast",
    }

end

function unilib.pkg.armour_shield_iron_cast.exec()

    unilib.register_armour("unilib:armour_shield_iron_cast", "technic_armor:shield_cast", mode, {
        -- From technic_armor:shield_cast
        description = S("Cast Iron Shield"),
        inventory_image = "unilib_armour_shield_iron_cast_inv.png",
        groups = {armour_heal = 8, armour_radiation = 0, armour_shield = 12, armour_use = 200},
    })
    unilib.register_craft_shield({
        -- From technic_armor:shield_cast
        part_name = "iron_cast",
        ingredient = "unilib:metal_iron_cast_ingot",
    })

end
