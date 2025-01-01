---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xtraores/xtraores_armor
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.armour_leggings_planexium = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xtraores_armor.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.armour_leggings_planexium.init()

    return {
        description = "Planexium leggings",
        depends = "metal_planexium",
    }

end

function unilib.pkg.armour_leggings_planexium.exec()

    unilib.register_armour(
        -- From xtraores_armor:leggings_platinum
        "unilib:armour_leggings_planexium",
        "xtraores_armor:leggings_platinum",
        mode,
        {
            description = S("Planexium Leggings"),
            inventory_image = "unilib_armour_leggings_planexium_inv.png",
            groups = {armour_heal = 7, armour_legs = 17, armour_use = 200},

            wear = 0,
        }
    )
    unilib.register_craft_leggings({
        -- From xtraores_armor:leggings_platinum
        part_name = "planexium",
        ingredient = "unilib:metal_planexium_ingot",
    })

end
