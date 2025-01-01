---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    morelights/morelights_vintage
-- Code:    LGPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.hardware_chain_brass_vintage = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.morelights_vintage.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.hardware_chain_brass_vintage.init()

    return {
        description = "Vintage brass chain",
        depends = "metal_brass",
    }

end

function unilib.pkg.hardware_chain_brass_vintage.exec()

    unilib.register_node(
        -- From morelights_vintage:chain_b
        "unilib:hardware_chain_brass_vintage",
        "morelights_vintage:chain_b",
        mode,
        {
            description = S("Hanging Vintage Brass Chain"),
            tiles = {"unilib_hardware_chain_brass_vintage.png"},
            groups = {cracky = 3, handy = 1, mounted_ceiling = 1, oddly_breakable_by_hand = 3},
            sounds = unilib.global.sound_table.metal,

            collision_box = {
                type = "fixed",
                fixed = {-1/16, -8/16, -1/16, 1/16, 8/16, 1/16},
            },
            drawtype = "mesh",
            inventory_image = "unilib_hardware_chain_brass_vintage_inv.png",
            -- N.B. is_ground_content = false not in original code
            is_ground_content = false,
            mesh = "unilib_chain_metal.obj",
            paramtype = "light",
            selection_box = {
                type = "fixed",
                fixed = {-1/16, -8/16, -1/16, 1/16, 8/16, 1/16},
            },
            sunlight_propagates = true,
            wield_image = "unilib_hardware_chain_brass_vintage_inv.png",

            on_place = function(itemstack, placer, pointed_thing)

                return unilib.pkg.shared_morelights.on_place_hanging(
                    itemstack, placer, pointed_thing, "unilib:hardware_chain_brass_vintage_ceiling"
                )

            end,
        }
    )
    unilib.register_craft({
        -- From morelights_vintage:chain_b
        output = "unilib:hardware_chain_brass_vintage",
        recipe = {
            {"", "unilib:metal_brass_ingot", ""},
            {"", "", ""},
            {"", "unilib:metal_brass_ingot", ""},
        },
    })

    unilib.register_node(
        -- From morelights_vintage:chain_ceiling_b
        "unilib:hardware_chain_brass_vintage_ceiling",
        "morelights_vintage:chain_ceiling_b",
        mode,
        {
            -- (no description)
            tiles = {"unilib_hardware_chain_brass_vintage.png"},
            groups = {cracky = 3, handy = 1, mounted_ceiling = 1, oddly_breakable_by_hand = 3},
            unilib.global.sound_table.metal,

            collision_box = {
                type = "fixed",
                fixed = {
                    {-3/16, 7/16, -3/16, 3/16, 1/2, 3/16},
                    {-1/16, -1/2, -1/16, 1/16, 7/16, 1/16},
                },
            },
            drawtype = "mesh",
            drop = "unilib:hardware_chain_brass_vintage",
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
