---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xtraores/xtraores_armor
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.armour_boots_rarium = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xtraores_armor.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.armour_boots_rarium.init()

    return {
        description = "Rarium boots",
        depends = "metal_rarium",
    }

end

function unilib.pkg.armour_boots_rarium.exec()

    unilib.register_armour("unilib:armour_boots_rarium", "xtraores_armor:boots_rarium", mode, {
        -- From xtraores_armor:boots_rarium
        description = S("Rarium Boots"),
        inventory_image = "unilib_armour_boots_rarium_inv.png",
        groups = {
            armour_feet = 16.4, armour_heal = 12, armour_use = 20, physics_gravity = -0.15,
            physics_jump = 0.15, physics_speed = 0.15,
        },

        wear = 0,
    })
    unilib.register_craft_boots({
        -- From xtraores_armor:boots_rarium
        part_name = "rarium",
        ingredient = "unilib:metal_rarium_ingot",
    })

end
