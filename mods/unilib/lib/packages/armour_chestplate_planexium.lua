---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xtraores/xtraores_armor
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.armour_chestplate_planexium = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xtraores_armor.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.armour_chestplate_planexium.init()

    return {
        description = "Planexium chestplate",
        depends = "metal_planexium",
    }

end

function unilib.pkg.armour_chestplate_planexium.exec()

    unilib.register_armour(
        -- From xtraores_armor:chestplate_platinum
        "unilib:armour_chestplate_planexium",
        "xtraores_armor:chestplate_platinum",
        mode,
        {
            description = S("Planexium Chestplate"),
            inventory_image = "unilib_armour_chestplate_planexium_inv.png",
            groups = {armour_heal = 7, armour_torso = 17, armour_use = 200},

            wear = 0,
        }
    )
    unilib.register_craft_chestplate({
        -- From xtraores_armor:chestplate_platinum
        part_name = "planexium",
        ingredient = "unilib:metal_planexium_ingot",
    })

end
