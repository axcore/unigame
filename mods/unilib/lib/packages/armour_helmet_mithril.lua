---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    3d_armor/armor_mithril
-- Code:    LGPL v2.1
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.armour_helmet_mithril = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.armor_mithril.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.armour_helmet_mithril.init()

    return {
        description = "Mithril helmet",
        depends = "metal_mithril",
    }

end

function unilib.pkg.armour_helmet_mithril.exec()

    unilib.register_armour("unilib:armour_helmet_mithril", "3d_armor:helmet_mithril", mode, {
        -- From 3d_armor:helmet_mithril
        description = S("Mithril Helmet"),
        inventory_image = "unilib_armour_helmet_mithril_inv.png",
        groups = {armour_head = 1, armour_heal = 13, armour_use = 66},

        armour_groups = {fleshy = 16},
        damage_groups = {cracky = 2, level = 3, snappy = 1},
    })
    unilib.register_craft_helmet({
        -- From 3d_armor:helmet_mithril
        part_name = "mithril",
        ingredient = "unilib:metal_mithril_ingot",
    })

end
