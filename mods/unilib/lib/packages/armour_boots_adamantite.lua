---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xtraores/xtraores_armor
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.armour_boots_adamantite = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xtraores_armor.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.armour_boots_adamantite.init()

    return {
        description = "Adamantite boots",
        depends = "metal_adamantite",
    }

end

function unilib.pkg.armour_boots_adamantite.exec()

    unilib.register_armour(
        -- From xtraores_armor:boots_adamantite
        "unilib:armour_boots_adamantite",
        "xtraores_armor:boots_adamantite",
        mode,
        {
            description = S("Adamantite Boots"),
            inventory_image = "unilib_armour_boots_adamantite_inv.png",
            groups = {armour_feet = 16, armour_heal = 12, physics_gravity = -0.15},

            wear = 0,
        }
    )
    unilib.register_craft_boots({
        -- From xtraores_armor:boots_adamantite
        part_name = "adamantite",
        ingredient = "unilib:metal_adamantite_ingot",
    })

end
