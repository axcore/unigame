---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    morelights/morelights
-- Code:    LGPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.hardware_chain_metal_light = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.morelights.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.hardware_chain_metal_light.init()

    return {
        description = "Light metal chain",
        depends = {"dye_basic", "metal_steel", "shared_morelights"},
    }

end

function unilib.pkg.hardware_chain_metal_light.exec()

    unilib.register_node("unilib:hardware_chain_metal_light", "morelights:chain_l", mode, {
        -- From morelights:chain_l
        description = S("Hanging Light Metal Chain"),
        tiles = {"unilib_hardware_pole_metal_light.png"},
        groups = {cracky = 3, handy = 1, mounted_ceiling = 1, oddly_breakable_by_hand = 3},
        sounds = unilib.global.sound_table.metal,

        collision_box = {
            type = "fixed",
            fixed = {-1/16, -1/2, -1/16, 1/16, 1/2, 1/16},
        },
        drawtype = "mesh",
        inventory_image = "unilib_hardware_chain_metal_light_inv.png",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        mesh = "unilib_chain_metal.obj",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-1/16, -1/2, -1/16, 1/16, 1/2, 1/16},
        },
        sunlight_propagates = true,
        wield_image = "unilib_hardware_chain_metal_light_inv.png",

        on_place = function(itemstack, placer, pointed_thing)

            return unilib.pkg.shared_morelights.on_place_hanging(
                itemstack,
                placer,
                pointed_thing,
                "unilib:hardware_chain_metal_light_ceiling"
            )

        end,
    })
    unilib.register_craft({
        -- From morelights:chain_l
        output = "unilib:hardware_chain_metal_light",
        recipe = {
            {"unilib:dye_white", "unilib:metal_steel_ingot", ""},
            {"", "", ""},
            {"", "unilib:metal_steel_ingot", ""},
        },
    })

    -- (When attached to a ceiling, add a square bracket)
    unilib.register_node(
        -- From morelights:chain_ceiling_l
        "unilib:hardware_chain_metal_light_ceiling",
        "morelights:chain_ceiling_l",
        mode,
        {
            -- (no description)
            tiles = {"unilib_hardware_pole_metal_light.png"},
            groups = {
                cracky = 3, handy = 1, mounted_ceiling = 1, not_in_creative_inventory = 1,
                oddly_breakable_by_hand = 3,
            },
            sounds = unilib.global.sound_table.metal,

            collision_box = {
                type = "fixed",
                fixed = {
                    {-3/16, 7/16, -3/16, 3/16, 1/2, 3/16},
                    {-1/16, -1/2, -1/16, 1/16, 7/16, 1/16},
                },
            },
            drawtype = "mesh",
            drop = "unilib:hardware_chain_metal_light",
            -- N.B. is_ground_content = false not in original code
            is_ground_content = false,
            mesh = "unilib_chain_metal_ceiling.obj",
            paramtype = "light",
            selection_box = {
                type = "fixed",
                fixed = {
                    {-3/16, 7/16, -3/16, 3/16, 1/2, 3/16},
                    {-1/16, -1/2, -1/16, 1/16, 7/16, 1/16},
                },
            },
            sunlight_propagates = true,
        }
    )

end
