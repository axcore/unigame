---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xtraores/xtraores_armor
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.armour_shield_tritonium = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xtraores_armor.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.armour_shield_tritonium.init()

    return {
        description = "Tritonium shield",
        depends = {"metal_tritonium", "shared_armour_shield"},
    }

end

function unilib.pkg.armour_shield_tritonium.exec()

    unilib.register_armour(
        -- From xtraores_armor:shield_titanium
        "unilib:armour_shield_tritonium",
        "xtraores_armor:shield_titanium",
        mode,
        {
            description = S("Tritonium Shield"),
            inventory_image = "unilib_armour_shield_tritonium_inv.png",
            groups = {
                armour_fire = 1, armour_heal = 14, armour_shield = 17.6, armour_use = 20,
                physics_gravity = -0.18, physics_jump = 0.16, physics_speed = 0.25,
            },

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
        -- From xtraores_armor:shield_titanium
        part_name = "tritonium",
        ingredient = "unilib:metal_tritonium_ingot",
    })

end
