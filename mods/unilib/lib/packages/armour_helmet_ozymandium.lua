---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xtraores/xtraores_armor
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.armour_helmet_ozymandium = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xtraores_armor.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.armour_helmet_ozymandium.init()

    return {
        description = "Ozymandium helmet",
        depends = "metal_ozymandium",
    }

end

function unilib.pkg.armour_helmet_ozymandium.exec()

    unilib.register_armour(
        -- From xtraores_armor:helmet_osmium
        "unilib:armour_helmet_ozymandium",
        "xtraores_armor:helmet_osmium",
        mode,
        {
            description = S("Ozymandium Helmet"),
            inventory_image = "unilib_armour_helmet_ozymandium_inv.png",
            groups = {armour_head = 15.4, armour_heal = 12, physics_jump = 0.15},

            wear = 0,
        }
    )
    unilib.register_craft_helmet({
        -- From xtraores_armor:helmet_osmium
        part_name = "ozymandium",
        ingredient = "unilib:metal_ozymandium_ingot",
    })

end
