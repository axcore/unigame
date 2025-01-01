---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    morelights/morelights
-- Code:    LGPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.hardware_pole_metal_dark = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.morelights.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.hardware_pole_metal_dark.init()

    return {
        description = "Dark metal pole",
        depends = {"dye_basic", "metal_steel", "shared_morelights"},
    }

end

function unilib.pkg.hardware_pole_metal_dark.exec()

    unilib.register_node("unilib:hardware_pole_metal_dark", "morelights:pole_d", mode, {
        -- From morelights:pole_d
        description = S("Dark Metal Pole"),
        tiles = {"unilib_hardware_pole_metal_dark.png"},
        groups = {cracky = 3, handy = 1, mounted_ceiling = 1, oddly_breakable_by_hand = 3},
        sounds = unilib.global.sound_table.metal,

        drawtype = "nodebox",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {-1/32, -1/2, -1/32, 1/32, 1/2, 1/32},
        },
        inventory_image = "unilib_hardware_pole_metal_dark_inv.png",
        paramtype = "light",
        paramtype2 = "wallmounted",
        selection_box = {
            type = "fixed",
            fixed = {-1/16, -1/2, -1/16, 1/16, 1/2, 1/16},
        },
        sunlight_propagates = true,
        wield_image = "unilib_hardware_pole_metal_dark_inv.png",

        on_place = function(itemstack, placer, pointed_thing)

            return unilib.pkg.shared_morelights.on_place_hanging(
                itemstack,
                placer,
                pointed_thing,
                "unilib:hardware_pole_metal_dark_ceiling"
            )

        end,
    })
    unilib.register_craft({
        -- From morelights:pole_d
        output = "unilib:hardware_pole_metal_dark 2",
        recipe = {
            {"unilib:dye_grey_dark", "unilib:metal_steel_ingot", ""},
            {"", "unilib:metal_steel_ingot", ""},
            {"", "unilib:metal_steel_ingot", ""},
        },
    })

    -- (When attached to a ceiling, add a square bracket)
    unilib.register_node(
        -- From morelights:pole_ceiling_d
        "unilib:hardware_pole_metal_dark_ceiling",
        "morelights:pole_ceiling_d",
        mode,
        {
            -- (no description)
            tiles = {"unilib_hardware_pole_metal_dark.png"},
            groups = {
                cracky = 3, handy = 1, mounted_ceiling = 1, not_in_creative_inventory = 1,
                oddly_breakable_by_hand = 3,
            },
            sounds = unilib.global.sound_table.metal,

            drawtype = "nodebox",
            drop = "unilib:hardware_pole_metal_dark",
            -- N.B. is_ground_content = false not in original code
            is_ground_content = false,
            node_box = {
                type = "fixed",
                fixed = {
                    {-3/16, -7/16, -3/16, 3/16, -1/2, 3/16},
                    {-1/32, 1/2, -1/32, 1/32, -7/16, 1/32},
                },
            },
            paramtype = "light",
            paramtype2 = "wallmounted",
            selection_box = {
                type = "fixed",
                fixed = {
                    {-3/16, -7/16, -3/16, 3/16, -1/2, 3/16},
                    {-1/16, 1/2, -1/16, 1/16, -7/16, 1/16},
                },
            },
            sunlight_propagates = true,
        }
    )

end
