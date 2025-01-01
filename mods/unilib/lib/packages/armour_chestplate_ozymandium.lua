---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xtraores/xtraores_armor
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.armour_chestplate_ozymandium = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xtraores_armor.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.armour_chestplate_ozymandium.init()

    return {
        description = "Ozymandium chestplate",
        depends = "metal_ozymandium",
    }

end

function unilib.pkg.armour_chestplate_ozymandium.exec()

    unilib.register_armour(
        -- From xtraores_armor:chestplate_osmium
        "unilib:armour_chestplate_ozymandium",
        "xtraores_armor:chestplate_osmium",
        mode,
        {
            description = S("Ozymandium Chestplate"),
            inventory_image = "unilib_armour_chestplate_ozymandium_inv.png",
            groups = {armour_heal = 12, armour_torso = 20.4, physics_jump = 0.15},

            wear = 0,
        }
    )
    unilib.register_craft_chestplate({
        -- From xtraores_armor:chestplate_osmium
        part_name = "ozymandium",
        ingredient = "unilib:metal_ozymandium_ingot",
    })

end
