---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xtraores/xtraores_armor
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.armour_leggings_adamantite = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xtraores_armor.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.armour_leggings_adamantite.init()

    return {
        description = "Adamantite leggings",
        depends = "metal_adamantite",
    }

end

function unilib.pkg.armour_leggings_adamantite.exec()

    unilib.register_armour(
        -- From xtraores_armor:leggings_adamantite
        "unilib:armour_leggings_adamantite",
        "xtraores_armor:leggings_adamantite",
        mode,
        {
            description = S("Adamantite Leggings"),
            inventory_image = "unilib_armour_leggings_adamantite_inv.png",
            groups = {armour_heal = 12, armour_legs = 21, physics_gravity = -0.15},

            wear = 0,
        }
    )
    unilib.register_craft_leggings({
        -- From xtraores_armor:leggings_adamantite
        part_name = "adamantite",
        ingredient = "unilib:metal_adamantite_ingot",
    })

end
