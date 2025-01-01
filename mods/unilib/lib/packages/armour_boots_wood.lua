---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    3d_armor/armor_wood
-- Code:    LGPL v2.1
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.armour_boots_wood = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.armor_wood.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.armour_boots_wood.init()

    return {
        description = "Wooden boots",
    }

end

function unilib.pkg.armour_boots_wood.exec()

    unilib.register_armour("unilib:armour_boots_wood", "3d_armor:boots_wood", mode, {
        -- From 3d_armor:boots_wood
        description = S("Wooden Boots"),
        inventory_image = "unilib_armour_boots_wood_inv.png",
        groups = {armour_feet = 1, armour_heal = 0, armour_use = 2000, flammable = 1},

        armour_groups = {fleshy = 5},
        damage_groups = {choppy = 3, cracky = 3, crumbly = 2, level = 1, snappy = 2},
    })
    unilib.register_craft_boots({
        -- From 3d_armor:boots_wood
        part_name = "wood",
        ingredient = "group:wood",
    })
    unilib.register_craft({
        -- From 3d_armor:boots_wood
        type = "fuel",
        recipe = "unilib:armour_boots_wood",
        burntime = 5,
    })

end
