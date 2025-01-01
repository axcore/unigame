---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    technic_armor
-- Code:    LGPL v2.1
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.armour_leggings_tin = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.technic_armor.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.armour_leggings_tin.init()

    return {
        description = "Tin leggings",
        depends = "metal_tin",
    }

end

function unilib.pkg.armour_leggings_tin.exec()

    unilib.register_armour("unilib:armour_leggings_tin", "technic_armor:leggings_tin", mode, {
        -- From technic_armor:leggings_tin
        description = S("Tin Leggings"),
        inventory_image = "unilib_armour_leggings_tin_inv.png",
        groups = {armour_heal = 0, armour_legs = 11, armour_radiation = 5, armour_use = 750},
    })
    unilib.register_craft_leggings({
        -- From technic_armor:leggings_tin
        part_name = "tin",
        ingredient = "unilib:metal_tin_ingot",
    })

end
