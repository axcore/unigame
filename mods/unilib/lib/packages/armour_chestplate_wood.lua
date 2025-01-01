---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    3d_armor/armor_wood
-- Code:    LGPL v2.1
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.armour_chestplate_wood = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.armor_wood.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.armour_chestplate_wood.init()

    return {
        description = "Wooden chestplate",
    }

end

function unilib.pkg.armour_chestplate_wood.exec()

    unilib.register_armour("unilib:armour_chestplate_wood", "3d_armor:chestplate_wood", mode, {
        -- From 3d_armor:chestplate_wood
        description = S("Wooden Chestplate"),
        inventory_image = "unilib_armour_chestplate_wood_inv.png",
        groups = {armour_heal = 0, armour_torso = 1, armour_use = 2000, flammable = 1},

        armour_groups = {fleshy = 10},
        damage_groups = {choppy = 3, cracky = 3, crumbly = 2, level = 1, snappy = 2},
    })
    unilib.register_craft_chestplate({
        -- From 3d_armor:chestplate_wood
        part_name = "wood",
        ingredient = "group:wood",
    })
    unilib.register_craft({
        -- From 3d_armor:chestplate_wood
        type = "fuel",
        recipe = "unilib:armour_chestplate_wood",
        burntime = 8,
    })

end
