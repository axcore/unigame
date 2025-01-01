---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xtraores/xtraores_armor
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.armour_helmet_adamantite = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xtraores_armor.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.armour_helmet_adamantite.init()

    return {
        description = "Adamantite helmet",
        depends = "metal_adamantite",
    }

end

function unilib.pkg.armour_helmet_adamantite.exec()

    unilib.register_armour(
        -- From xtraores_armor:helmet_adamantite
        "unilib:armour_helmet_adamantite",
        "xtraores_armor:helmet_adamantite",
        mode,
        {
            description = S("Adamantite Helmet"),
            inventory_image = "unilib_armour_helmet_adamantite_inv.png",
            groups = {armour_head = 16, armour_heal = 12, physics_gravity = -0.15},

            wear = 0,
        }
    )
    unilib.register_craft_helmet({
        -- From xtraores_armor:helmet_adamantite
        part_name = "adamantite",
        ingredient = "unilib:metal_adamantite_ingot",
    })

end
