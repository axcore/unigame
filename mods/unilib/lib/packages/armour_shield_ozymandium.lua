---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xtraores/xtraores_armor
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.armour_shield_ozymandium = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xtraores_armor.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.armour_shield_ozymandium.init()

    return {
        description = "Ozymandium shield",
        depends = {"metal_ozymandium", "shared_armour_shield"},
    }

end

function unilib.pkg.armour_shield_ozymandium.exec()

    unilib.register_armour(
        -- From xtraores_armor:shield_osmium
        "unilib:armour_shield_ozymandium",
        "xtraores_armor:shield_osmium",
        mode,
        {
            description = S("Ozymandium Shield"),
            inventory_image = "unilib_armour_shield_ozymandium_inv.png",
            groups = {armour_heal = 12, armour_shield = 15.4, physics_jump = 0.15},

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
        -- From xtraores_armor:shield_osmium
        part_name = "ozymandium",
        ingredient = "unilib:metal_ozymandium_ingot",
    })

end
