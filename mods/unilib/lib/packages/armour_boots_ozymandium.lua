---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xtraores/xtraores_armor
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.armour_boots_ozymandium = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xtraores_armor.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.armour_boots_ozymandium.init()

    return {
        description = "Ozymandium boots",
        depends = "metal_ozymandium",
    }

end

function unilib.pkg.armour_boots_ozymandium.exec()

    unilib.register_armour("unilib:armour_boots_ozymandium", "xtraores_armor:boots_osmium", mode, {
        -- From xtraores_armor:boots_osmium
        description = S("Ozymandium Boots"),
        inventory_image = "unilib_armour_boots_ozymandium_inv.png",
        groups = {armour_feet = 15.4, armour_heal = 12, physics_jump = 0.15},

        wear = 0,
    })
    unilib.register_craft_boots({
        -- From xtraores_armor:boots_osmium
        part_name = "ozymandium",
        ingredient = "unilib:metal_ozymandium_ingot",
    })

end
