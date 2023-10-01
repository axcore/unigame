---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    morelights/morelights
-- Code:    LGPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.pole_metal_light = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.morelights.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.pole_metal_light.init()

    return {
        description = "Light metal pole",
        depends = {"dye_basic", "metal_steel", "shared_morelights"},
    }

end

function unilib.pkg.pole_metal_light.exec()

    unilib.register_node("unilib:pole_metal_light", "morelights:pole_l", mode, {
        -- From morelights:pole_l
        description = S("Light Metal Pole"),
        tiles = {"unilib_pole_metal_light.png"},
        groups = {cracky = 3, handy = 1, mounted_ceiling = 1, oddly_breakable_by_hand = 3},
        sounds = unilib.sound_table.metal,

        drawtype = "nodebox",
        inventory_image = "unilib_pole_metal_light_inv.png",
        node_box = {
            type = "fixed",
            fixed = {-1/32, -1/2, -1/32, 1/32, 1/2, 1/32},
        },
        paramtype = "light",
        paramtype2 = "wallmounted",
        selection_box = {
            type = "fixed",
            fixed = {-1/16, -1/2, -1/16, 1/16, 1/2, 1/16},
        },
        sunlight_propagates = true,
        wield_image = "unilib_pole_metal_light_inv.png",

        on_place = function(itemstack, placer, pointed_thing)

            return unilib.pkg.shared_morelights.on_place_hanging(
                itemstack,
                placer,
                pointed_thing,
                "unilib:pole_metal_light_ceiling"
            )

        end,
    })
    unilib.register_craft({
        -- From morelights:pole_l
        output = "unilib:pole_metal_light 2",
        recipe = {
            {"unilib:dye_white", "unilib:metal_steel_ingot", ""},
            {"", "unilib:metal_steel_ingot", ""},
            {"", "unilib:metal_steel_ingot", ""}
        }
    })

    -- (When attached to a ceiling, add a square bracket)
    unilib.register_node("unilib:pole_metal_light_ceiling", "morelights:pole_ceiling_l", mode, {
        -- From morelights:pole_ceiling_l
        -- (no description)
        tiles = {"unilib_pole_metal_light.png"},
        groups = {
            cracky = 3, handy = 1, mounted_ceiling = 1, not_in_creative_inventory = 1,
            oddly_breakable_by_hand = 3,
        },
        sounds = unilib.sound_table.metal,

        drawtype = "nodebox",
        drop = "unilib:pole_metal_light",
        node_box = {
            type = "fixed",
            fixed = {
                {-3/16, -7/16, -3/16, 3/16, -1/2, 3/16},
                {-1/32, 1/2, -1/32, 1/32, -7/16, 1/32},
            }
        },
        paramtype = "light",
        paramtype2 = "wallmounted",
        selection_box = {
            type = "fixed",
            fixed = {
                {-3/16, -7/16, -3/16, 3/16, -1/2, 3/16},
                {-1/16, 1/2, -1/16, 1/16, -7/16, 1/16},
            }
        },
        sunlight_propagates = true,
    })

end
