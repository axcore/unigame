---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xtraores/xtraores_armor
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.armour_shield_sybilline = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xtraores_armor.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.armour_shield_sybilline.init()

    return {
        description = "Sybilline shield",
        depends = {"metal_sybilline", "shared_armour_shield"},
    }

end

function unilib.pkg.armour_shield_sybilline.exec()

    unilib.register_armour("unilib:armour_shield_sybilline", "xtraores_armor:shield_cobalt", mode, {
        -- From xtraores_armor:shield_cobalt
        description = S("Sybilline Shield"),
        inventory_image = "unilib_armour_shield_sybilline_inv.png",
        groups = {armour_heal = 12, armour_shield = 15, armour_use = 75, physics_speed = 0.15},

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
        -- From xtraores_armor:shield_cobalt
        part_name = "sybilline",
        ingredient = "unilib:metal_sybilline_ingot",
    })

end
