---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xtraores/xtraores_armor
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.armour_shield_adamantite = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xtraores_armor.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.armour_shield_adamantite.init()

    return {
        description = "Adamantite shield",
        depends = {"metal_adamantite", "shared_armour_shield"},
    }

end

function unilib.pkg.armour_shield_adamantite.exec()

    unilib.register_armour(
        -- From xtraores_armor:shield_adamantite
        "unilib:armour_shield_adamantite",
        "xtraores_armor:shield_adamantite",
        mode,
        {
            description = S("Adamantite Shield"),
            inventory_image = "unilib_armour_shield_adamantite_inv.png",
            groups = {armour_heal = 12, armour_shield = 16, physics_gravity = -0.15},

            wear = 0,

            -- N.B. .on_damage(), .on_destroy() not in original code
            on_damage = function(player, index, stack)
                unilib.pkg.shared_armour_shield.play_shield_sound(player, "unilib_dig_metal")
            end,

            on_destroy = function(player, index, stack)
                unilib.pkg.shared_armour_shield.play_shield_sound(player, "unilib_dug_metal")
            end,
        }
    )
    unilib.register_craft_shield({
        -- From xtraores_armor:shield_adamantite
        part_name = "adamantite",
        ingredient = "unilib:metal_adamantite_ingot",
    })

end
