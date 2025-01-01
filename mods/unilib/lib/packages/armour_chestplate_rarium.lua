---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xtraores/xtraores_armor
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.armour_chestplate_rarium = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xtraores_armor.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.armour_chestplate_rarium.init()

    return {
        description = "Rarium chestplate",
        depends = "metal_rarium",
    }

end

function unilib.pkg.armour_chestplate_rarium.exec()

    unilib.register_armour(
        -- From xtraores_armor:chestplate_rarium
        "unilib:armour_chestplate_rarium",
        "xtraores_armor:chestplate_rarium",
        mode,
        {
            description = S("Rarium Chestplate"),
            inventory_image = "unilib_armour_chestplate_rarium_inv.png",
            groups = {
                armour_heal = 12, armour_torso = 21.4, armour_use = 20, physics_gravity = -0.15,
                physics_jump = 0.15, physics_speed = 0.15,
            },

            wear = 0,
        }
    )
    unilib.register_craft_chestplate({
        -- From xtraores_armor:chestplate_rarium
        part_name = "rarium",
        ingredient = "unilib:metal_rarium_ingot",
    })

end
