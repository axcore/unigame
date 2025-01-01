---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xtraores/xtraores_armor
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.armour_boots_sybilline = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xtraores_armor.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.armour_boots_sybilline.init()

    return {
        description = "Sybilline boots",
        depends = "metal_sybilline",
    }

end

function unilib.pkg.armour_boots_sybilline.exec()

    unilib.register_armour("unilib:armour_boots_sybilline", "xtraores_armor:boots_cobalt", mode, {
        -- From xtraores_armor:boots_cobalt
        description = S("Sybilline Boots"),
        inventory_image = "unilib_armour_boots_sybilline_inv.png",
        groups = {armour_feet = 15, armour_heal = 12, armour_use = 75, physics_speed = 0.15},

        wear = 0,
    })
    unilib.register_craft_boots({
        -- From xtraores_armor:boots_cobalt
        part_name = "sybilline",
        ingredient = "unilib:metal_sybilline_ingot",
    })

end
