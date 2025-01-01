---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    3d_armor/shields
-- Code:    LGPL v2.1
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.armour_shield_mithril = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.shields.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.armour_shield_mithril.init()

    return {
        description = "Mithril shield",
        depends = {"metal_mithril", "shared_armour_shield"},
    }

end

function unilib.pkg.armour_shield_mithril.exec()

    unilib.register_armour("unilib:armour_shield_mithril", "shields:shield_mithril", mode, {
        -- From shields:shield_mithril
        description = S("Mithril Shield"),
        inventory_image = "unilib_armour_shield_mithril_inv.png",
        groups = {armour_heal = 13, armour_shield = 1, armour_use = 66},

        armour_groups = {fleshy = 16},
        damage_groups = {cracky = 2, level = 3, snappy = 1},
        reciprocate_damage = true,

        on_damage = function(player, index, stack)
            unilib.pkg.shared_armour_shield.play_shield_sound(player, "unilib_glass_footstep")
        end,

        on_destroy = function(player, index, stack)
            unilib.pkg.shared_armour_shield.play_shield_sound(player, "unilib_break_glass")
        end,
    })
    unilib.register_craft_shield({
        -- From shields:shield_mithril
        part_name = "mithril",
        ingredient = "unilib:metal_mithril_ingot",
    })

end
