---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xtraores/xtraores_armor
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.armour_leggings_ozymandium = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xtraores_armor.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.armour_leggings_ozymandium.init()

    return {
        description = "Ozymandium leggings",
        depends = "metal_ozymandium",
    }

end

function unilib.pkg.armour_leggings_ozymandium.exec()

    unilib.register_armour(
        -- From xtraores_armor:leggings_osmium
        "unilib:armour_leggings_ozymandium",
        "xtraores_armor:leggings_osmium",
        mode,
        {
            description = S("Ozymandium Leggings"),
            inventory_image = "unilib_armour_leggings_ozymandium_inv.png",
            groups = {armour_heal = 12, armour_legs = 20.4, physics_jump = 0.15},

            wear = 0,
        }
    )
    unilib.register_craft_leggings({
        -- From xtraores_armor:leggings_osmium
        part_name = "ozymandium",
        ingredient = "unilib:metal_ozymandium_ingot",
    })

end
