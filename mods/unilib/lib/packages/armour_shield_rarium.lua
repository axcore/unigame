---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xtraores/xtraores_armor
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.armour_shield_rarium = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xtraores_armor.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.armour_shield_rarium.init()

    return {
        description = "Rarium shield",
        depends = {"metal_rarium", "shared_armour_shield"},
    }

end

function unilib.pkg.armour_shield_rarium.exec()

    unilib.register_armour("unilib:armour_shield_rarium", "xtraores_armor:shield_rarium", mode, {
        -- From xtraores_armor:shield_rarium
        description = S("Rarium Shield"),
        inventory_image = "unilib_armour_shield_rarium_inv.png",
        groups = {
            armour_heal = 12, armour_shield = 16.4, armour_use = 20, physics_gravity = -0.15,
            physics_jump = 0.15, physics_speed = 0.15,
        },

        wear = 0,

        -- N.B. .on_damage(), .on_destroy() not in original code
        on_damage = function(player, index, stack)
            unilib.pkg.shared_armour_shield.play_shield_sound(player, "unilib_dig_metal")
        end,

        on_destroy = function(player, index, stack)
            unilib.pkg.shared_armour_shield.play_shield_sound(player, "unilib_dug_metal")
        end,
    })
    unilib.register_craft_shield({
        -- From xtraores_armor:shield_rarium
        part_name = "rarium",
        ingredient = "unilib:metal_rarium_ingot",
    })

end
