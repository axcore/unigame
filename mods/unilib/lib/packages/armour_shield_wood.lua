---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    3d_armor/shields
-- Code:    LGPL v2.1
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.armour_shield_wood = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.shields.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.armour_shield_wood.init()

    return {
        description = "Wooden shield",
        depends = "shared_armour_shield",
        optional = "metal_steel",
    }

end

function unilib.pkg.armour_shield_wood.exec()

    unilib.register_armour("unilib:armour_shield_wood", "shields:shield_wood", mode, {
        -- From shields:shield_wood
        description = S("Wooden Shield"),
        inventory_image = "unilib_armour_shield_wood_inv.png",
        groups = {armour_heal = 0, armour_shield = 1, armour_use = 2000, flammable = 1},

        armour_groups = {fleshy = 5},
        damage_groups = {choppy = 3, cracky = 3, crumbly = 2, level = 1, snappy = 2},
        reciprocate_damage = true,

        on_damage = function(player, index, stack)
            unilib.pkg.shared_armour_shield.play_shield_sound(player, "unilib_wood_footstep")
        end,

        on_destroy = function(player, index, stack)
            unilib.pkg.shared_armour_shield.play_shield_sound(player, "unilib_wood_footstep")
        end,
    })
    unilib.register_craft_shield({
        -- From shields:shield_wood
        part_name = "wood",
        ingredient = "group:wood",
    })
    unilib.register_craft({
        -- From shields:shield_wood
        type = "fuel",
        recipe = "unilib:armour_shield_wood",
        burntime = 8,
    })

    if unilib.global.pkg_executed_table["metal_steel"] ~= nil then

        unilib.register_armour(
            -- From shields:shield_enhanced_wood
            "unilib:armour_shield_wood_enhanced",
            "shields:shield_enhanced_wood",
            mode,
            {
                description = S("Enhanced Wooden Shield"),
                inventory_image = "unilib_armour_shield_wood_enhanced_inv.png",
                groups = {armour_heal = 0, armour_shield = 1, armour_use = 2000},

                armour_groups = {fleshy = 8},
                damage_groups = {choppy = 3, cracky = 3, crumbly = 2, level = 2, snappy = 2},
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
            -- From shields:shield_enhanced_wood
            output = "unilib:armour_shield_wood_enhanced",
            recipe = {
                {"unilib:metal_steel_ingot"},
                {"unilib:armour_shield_wood"},
                {"unilib:metal_steel_ingot"},
            },
        })

    end

end
