---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xtraores/xtraores_armor
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.armour_helmet_sybilline = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xtraores_armor.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.armour_helmet_sybilline.init()

    return {
        description = "Sybilline helmet",
        depends = "metal_sybilline",
    }

end

function unilib.pkg.armour_helmet_sybilline.exec()

    unilib.register_armour(
        -- From xtraores_armor:helmet_cobalt
        "unilib:armour_helmet_sybilline",
        "xtraores_armor:helmet_cobalt",
        mode,
        {
            description = S("Sybilline Helmet"),
            inventory_image = "unilib_armour_helmet_sybilline_inv.png",
            groups = {armour_heal = 12, armour_head = 15, armour_use = 75, physics_speed = 0.15},

            wear = 0,
        }
    )
    unilib.register_craft_helmet({
        -- From xtraores_armor:helmet_cobalt
        part_name = "sybilline",
        ingredient = "unilib:metal_sybilline_ingot",
    })

end
