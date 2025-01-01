---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    3d_armor/shields
-- Code:    LGPL v2.1
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.armour_shield_nether = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.shields.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.armour_shield_nether.init()

    return {
        description = "Nether shield",
        mod_depends = "nether",
        depends = "shared_armour_shield",
    }

end

function unilib.pkg.armour_shield_nether.exec()

    unilib.register_armour("unilib:armour_shield_nether", "shields:shield_nether", mode, {
        -- From shields:shield_nether
        description = S("Nether Shield"),
        inventory_image = "unilib_armour_shield_nether_inv.png",
        groups = {armour_fire = 1, armour_heal = 17, armour_shield = 1, armour_use = 200},

        armour_groups = {fleshy = 20},
        damage_groups = {cracky = 3, level = 3, snappy = 2},
        reciprocate_damage = true,

        on_damage = function(player, index, stack)
            unilib.pkg.shared_armour_shield.play_shield_sound(player, "unilib_glass_footstep")
        end,

        on_destroy = function(player, index, stack)
            unilib.pkg.shared_armour_shield.play_shield_sound(player, "unilib_break_glass")
        end,
    })
    unilib.register_craft_shield({
        -- From shields:shield_nether
        part_name = "nether",
        ingredient = "nether:nether_ingot",
    })

end
