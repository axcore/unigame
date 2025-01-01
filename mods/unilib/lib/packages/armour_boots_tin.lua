---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    technic_armor
-- Code:    LGPL v2.1
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.armour_boots_tin = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.technic_armor.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.armour_boots_tin.init()

    return {
        description = "Tin boots",
        depends = "metal_tin",
    }

end

function unilib.pkg.armour_boots_tin.exec()

    unilib.register_armour("unilib:armour_boots_tin", "technic_armor:boots_tin", mode, {
        -- From technic_armor:boots_tin
        description = S("Tin Boots"),
        inventory_image = "unilib_armour_boots_tin_inv.png",
        groups = {armour_feet = 6, armour_heal = 0, armour_radiation = 3, armour_use = 750},
    })
    unilib.register_craft_boots({
        -- From technic_armor:boots_tin
        part_name = "tin",
        ingredient = "unilib:metal_tin_ingot",
    })

end
