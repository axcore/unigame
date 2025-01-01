---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    technic_armor
-- Code:    LGPL v2.1
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.armour_shield_tin = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.technic_armor.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.armour_shield_tin.init()

    return {
        description = "Tin shield",
        depends = "metal_tin",
    }

end

function unilib.pkg.armour_shield_tin.exec()

    unilib.register_armour("unilib:armour_shield_tin", "technic_armor:shield_tin", mode, {
        -- From technic_armor:shield_tin
        description = S("Tin Shield"),
        inventory_image = "unilib_armour_shield_tin_inv.png",
        groups = {armour_heal = 0, armour_radiation = 0, armour_shield = 8, armour_use = 750},
    })
    unilib.register_craft_shield({
        -- From technic_armor:shield_tin
        part_name = "tin",
        ingredient = "unilib:metal_tin_ingot",
    })

end
