---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xtraores/xtraores_armor
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.armour_chestplate_sybilline = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xtraores_armor.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.armour_chestplate_sybilline.init()

    return {
        description = "Sybilline chestplate",
        depends = "metal_sybilline",
    }

end

function unilib.pkg.armour_chestplate_sybilline.exec()

    unilib.register_armour(
        -- From xtraores_armor:chestplate_cobalt
        "unilib:armour_chestplate_sybilline",
        "xtraores_armor:chestplate_cobalt",
        mode,
        {
            description = S("Sybilline Chestplate"),
            inventory_image = "unilib_armour_chestplate_sybilline_inv.png",
            groups = {armour_heal = 12, armour_torso = 20, armour_use = 75, physics_speed = 0.15},

            wear = 0,
        }
    )
    unilib.register_craft_chestplate({
        -- From xtraores_armor:chestplate_cobalt
        part_name = "sybilline",
        ingredient = "unilib:metal_sybilline_ingot",
    })

end
