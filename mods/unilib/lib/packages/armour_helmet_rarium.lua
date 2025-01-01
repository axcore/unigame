---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xtraores/xtraores_armor
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.armour_helmet_rarium = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xtraores_armor.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.armour_helmet_rarium.init()

    return {
        description = "Rarium helmet",
        depends = "metal_rarium",
    }

end

function unilib.pkg.armour_helmet_rarium.exec()

    unilib.register_armour("unilib:armour_helmet_rarium", "xtraores_armor:helmet_rarium", mode, {
        -- From xtraores_armor:helmet_rarium
        description = S("Rarium Helmet"),
        inventory_image = "unilib_armour_helmet_rarium_inv.png",
        groups = {
            armour_head = 16.4, armour_heal = 12, armour_use = 20, physics_gravity = -0.15,
            physics_jump = 0.15, physics_speed = 0.15,
        },

        wear = 0,
    })
    unilib.register_craft_helmet({
        -- From xtraores_armor:helmet_rarium
        part_name = "rarium",
        ingredient = "unilib:metal_rarium_ingot",
    })

end
