---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    3d_armor/shields
-- Code:    LGPL v2.1
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.armour_shield_gold = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.shields.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.armour_shield_gold.init()

    return {
        description = "Gold shield",
        depends = {"metal_gold", "shared_armour_shield"},
    }

end

function unilib.pkg.armour_shield_gold.exec()

    unilib.register_armour("unilib:armour_shield_gold", "shields:shield_gold", mode, {
        -- From shields:shield_gold
        description = S("Gold Shield"),
        inventory_image = "unilib_armour_shield_gold_inv.png",
        groups = {
            armour_heal = 6, armour_shield = 1, armour_use = 300, physics_gravity = 0.04,
            physics_speed = -0.04,
        },

        armour_groups = {fleshy = 10},
        damage_groups = {choppy = 2, cracky = 1, crumbly = 3, level = 2, snappy = 2},
        reciprocate_damage = true,

        on_damage = function(player, index, stack)
            unilib.pkg.shared_armour_shield.play_shield_sound(player, "unilib_dig_metal")
        end,

        on_destroy = function(player, index, stack)
            unilib.pkg.shared_armour_shield.play_shield_sound(player, "unilib_dug_metal")
        end,
    })
    unilib.register_craft_shield({
        -- From shields:shield_gold
        part_name = "gold",
        ingredient = "unilib:metal_gold_ingot",
    })

end
