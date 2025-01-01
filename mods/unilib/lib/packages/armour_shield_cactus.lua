---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    3d_armor/shields
-- Code:    LGPL v2.1
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.armour_shield_cactus = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.shields.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.armour_shield_cactus.init()

    return {
        description = "Cactus shield",
        depends = {"plant_cactus_ordinary", "shared_armour_shield"},
        optional = "metal_steel",
    }

end

function unilib.pkg.armour_shield_cactus.exec()

    unilib.register_armour("unilib:armour_shield_cactus", "shields:shield_cactus", mode, {
        -- From shields:shield_cactus
        description = S("Cactus Shield"),
        inventory_image = "unilib_armour_shield_cactus_inv.png",
        groups = {armour_heal = 0, armour_shield = 1, armour_use = 1000},

        armour_groups = {fleshy = 5},
        damage_groups = {choppy = 2, cracky = 3, crumbly = 2, level = 1, snappy = 3},
        reciprocate_damage = true,

        on_damage = function(player, index, stack)
            unilib.pkg.shared_armour_shield.play_shield_sound(player, "unilib_wood_foostep")
        end,

        on_destroy = function(player, index, stack)
            unilib.pkg.shared_armour_shield.play_shield_sound(player, "unilib_wood_foostep")
        end,
    })
    unilib.register_craft_shield({
        -- From shields:shield_cactus
        part_name = "cactus",
        ingredient = "unilib:plant_cactus_ordinary",
    })
    unilib.register_craft({
        -- From shields:shield_cactus
        type = "fuel",
        recipe = "unilib:armour_shield_cactus",
        burntime = 16,
    })

    if unilib.global.pkg_executed_table["metal_steel"] ~= nil then

        unilib.register_armour(
            -- From shields:shield_enhanced_cactus
            "unilib:armour_shield_cactus_enhanced",
            "shields:shield_enhanced_cactus",
            mode,
            {
                description = S("Enhanced Cactus Shield"),
                inventory_image = "unilib_armour_shield_cactus_enhanced_inv.png",
                groups = {armour_heal = 0, armour_shield = 1, armour_use = 1000},

                armour_groups = {fleshy = 8},
                damage_groups = {choppy = 2, cracky = 3, crumbly = 2, level = 2, snappy = 3},
                reciprocate_damage = true,

                on_damage = function(player, index, stack)
                    unilib.pkg.shared_armour_shield.play_shield_sound(player, "unilib_dig_metal")
                end,

                on_destroy = function(player, index, stack)
                    unilib.pkg.shared_armour_shield.play_shield_sound(player, "unilib_dug_metal")
                end,
            }
        )
        unilib.register_craft({
            -- From shields:shield_enhanced_cactus
            output = "unilib:armour_shield_cactus_enhanced",
            recipe = {
                {"unilib:metal_steel_ingot"},
                {"unilib:armour_shield_cactus"},
                {"unilib:metal_steel_ingot"},
            },
        })

    end

end
