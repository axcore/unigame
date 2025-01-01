---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    technic_armor
-- Code:    LGPL v2.1
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.armour_chestplate_tin = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.technic_armor.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.armour_chestplate_tin.init()

    return {
        description = "Tin chestplate",
        depends = "metal_tin",
    }

end

function unilib.pkg.armour_chestplate_tin.exec()

    unilib.register_armour("unilib:armour_chestplate_tin", "technic_armor:chestplate_tin", mode, {
        -- From technic_armor:chestplate_tin
        description = S("Tin Chestplate"),
        inventory_image = "unilib_armour_chestplate_tin_inv.png",
        groups = {armour_heal = 0, armour_radiation = 12, armour_torso = 12, armour_use = 750},
    })
    unilib.register_craft_chestplate({
        -- From technic_armor:chestplate_tin
        part_name = "tin",
        ingredient = "unilib:metal_tin_ingot",
    })

end
