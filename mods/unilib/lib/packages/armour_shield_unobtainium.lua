---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xtraores/xtraores_armor
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.armour_shield_unobtainium = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xtraores_armor.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.armour_shield_unobtainium.init()

    return {
        description = "Unobtainium shield",
        depends = {"metal_unobtainium", "shared_armour_shield"},
    }

end

function unilib.pkg.armour_shield_unobtainium.exec()

    unilib.register_armour(
        -- From xtraores_armor:shield_unobtainium
        "unilib:armour_shield_unobtainium",
        "xtraores_armor:shield_unobtainium",
        mode,
        {
            description = S("Unobtainium Shield"),
            inventory_image = "unilib_armour_shield_unobtainium_inv.png",
            groups = {
                armour_fire = 1, armour_heal = 12, armour_shield = 17, armour_use = 20,
                physics_gravity = -0.15, physics_jump = 0.15, physics_speed = 0.15,
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
        -- From xtraores_armor:shield_unobtainium
        part_name = "unobtainium",
        ingredient = "unilib:metal_unobtainium_ingot",
    })

end
