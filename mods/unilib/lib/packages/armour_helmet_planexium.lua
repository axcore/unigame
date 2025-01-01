---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xtraores/xtraores_armor
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.armour_helmet_planexium = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xtraores_armor.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.armour_helmet_planexium.init()

    return {
        description = "Planexium helmet",
        depends = "metal_planexium",
    }

end

function unilib.pkg.armour_helmet_planexium.exec()

    unilib.register_armour(
        -- From xtraores_armor:helmet_platinum
        "unilib:armour_helmet_planexium",
        "xtraores_armor:helmet_platinum",
        mode,
        {
            description = S("Planexium Helmet"),
            inventory_image = "unilib_armour_helmet_planexium_inv.png",
            groups = {armour_head = 12, armour_heal = 7, armour_use = 200},

            wear = 0,
        }
    )
    unilib.register_craft_helmet({
        -- From xtraores_armor:helmet_platinum
        part_name = "planexium",
        ingredient = "unilib:metal_planexium_ingot",
    })

end
