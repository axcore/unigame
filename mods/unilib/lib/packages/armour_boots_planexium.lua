---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xtraores/xtraores_armor
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.armour_boots_planexium = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xtraores_armor.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.armour_boots_planexium.init()

    return {
        description = "Planexium boots",
        depends = "metal_planexium",
    }

end

function unilib.pkg.armour_boots_planexium.exec()

    unilib.register_armour("unilib:armour_boots_planexium", "xtraores_armor:boots_platinum", mode, {
        -- From xtraores_armor:boots_platinum
        description = S("Planexium Boots"),
        inventory_image = "unilib_armour_boots_planexium_inv.png",
        groups = {armour_feet = 12, armour_heal = 7, armour_use = 200},

        wear = 0,
    })
    unilib.register_craft_boots({
        -- From xtraores_armor:boots_platinum
        part_name = "planexium",
        ingredient = "unilib:metal_planexium_ingot",
    })

end
