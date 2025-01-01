---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    3d_armor/shields
-- Code:    LGPL v2.1
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.armour_shield_steel = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.shields.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.armour_shield_steel.init()

    return {
        description = "Steel shield",
        depends = {"metal_steel", "shared_armour_shield"},
    }

end

function unilib.pkg.armour_shield_steel.exec()

    unilib.register_armour("unilib:armour_shield_steel", "shields:shield_steel", mode, {
        -- From shields:shield_steel
        description = S("Steel Shield"),
        inventory_image = "unilib_armour_shield_steel_inv.png",
        groups = {
            armour_heal = 0, armour_shield = 1, armour_use = 800, physics_gravity = 0.03,
            physics_speed = -0.03,
        },

        armour_groups = {fleshy = 10},
        damage_groups = {choppy = 2, cracky = 2, crumbly = 1, level = 2, snappy = 3},
        reciprocate_damage = true,

        on_damage = function(player, index, stack)
            unilib.pkg.shared_armour_shield.play_shield_sound(player, "unilib_dig_metal")
        end,

        on_destroy = function(player, index, stack)
            unilib.pkg.shared_armour_shield.play_shield_sound(player, "unilib_dug_metal")
        end,
    })
    unilib.register_craft_shield({
        -- From shields:shield_steel
        part_name = "steel",
        ingredient = "unilib:metal_steel_ingot",
    })

end
