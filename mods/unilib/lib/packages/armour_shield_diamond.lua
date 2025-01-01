---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    3d_armor/shields
-- Code:    LGPL v2.1
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.armour_shield_diamond = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.shields.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.armour_shield_diamond.init()

    return {
        description = "Diamond shield",
        depends = {"mineral_diamond", "shared_armour_shield"},
    }

end

function unilib.pkg.armour_shield_diamond.exec()

    unilib.register_armour("unilib:armour_shield_diamond", "shields:shield_diamond", mode, {
        -- From shields:shield_diamond
        description = S("Diamond Shield"),
        inventory_image = "unilib_armour_shield_diamond_inv.png",
        groups = {armour_heal = 12, armour_shield = 1, armour_use = 200},

        armour_groups = {fleshy = 15},
        damage_groups = {choppy = 1, cracky = 2, level = 3, snappy = 1},
        reciprocate_damage = true,

        on_damage = function(player, index, stack)
            unilib.pkg.shared_armour_shield.play_shield_sound(player, "unilib_glass_footstep")
        end,

        on_destroy = function(player, index, stack)
            unilib.pkg.shared_armour_shield.play_shield_sound(player, "unilib_break_glass")
        end,
    })
    unilib.register_craft_shield({
        -- From shields:shield_diamond
        part_name = "diamond",
        ingredient = "unilib:mineral_diamond_gem",
    })

end
