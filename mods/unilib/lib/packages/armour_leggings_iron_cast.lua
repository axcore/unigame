---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    technic_armor
-- Code:    LGPL v2.1
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.armour_leggings_iron_cast = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.technic_armor.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.armour_leggings_iron_cast.init()

    return {
        description = "Cast iron leggings",
        depends = "metal_iron_cast",
    }

end

function unilib.pkg.armour_leggings_iron_cast.exec()

    unilib.register_armour(
        -- From technic_armor:leggings_cast
        "unilib:armour_leggings_iron_cast",
        "technic_armor:leggings_cast",
        mode,
        {
            description = S("Cast Iron Leggings"),
            inventory_image = "unilib_armour_leggings_iron_cast_inv.png",
            groups = {armour_heal = 8, armour_legs = 17, armour_radiation = 6, armour_use = 200},
        }
    )
    unilib.register_craft_leggings({
        -- From technic_armor:leggings_cast
        part_name = "iron_cast",
        ingredient = "unilib:metal_iron_cast_ingot",
    })

end
