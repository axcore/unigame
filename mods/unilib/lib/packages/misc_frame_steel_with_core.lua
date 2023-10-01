---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    nbea
-- Code:    WTFPL
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_frame_steel_with_core = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.nbea.add_mode

local rules_table = {
    {x = 0, y = 0, z = -1},
    {x = 1, y = 0, z = 0},
    {x = -1, y = 0, z = 0},
    {x = 0, y = 0, z = 1},
    {x = 1, y = 1, z = 0},
    {x = 1, y = -1, z = 0},
    {x = -1, y = 1, z = 0},
    {x = -1, y = -1, z = 0},
    {x = 0, y = 1, z = 1},
    {x = 0, y = -1, z = 1},
    {x = 0, y = 1, z = -1},
    {x = 0, y = -1, z = -1},
    {x = 0, y = -1, z = 0},
}

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_frame_steel_with_core.init()

    return {
        description = "Steel frame with glowing core",
        notes = "The core fluctuates when connected to a live mesecon circuit",
        depends = {"metal_steel", "mineral_mese"},
    }

end

function unilib.pkg.misc_frame_steel_with_core.exec()

    local c_steel = "unilib:metal_steel_ingot"

    unilib.register_node("unilib:misc_frame_steel_with_core", "nbea:nbox_003", mode, {
        -- From nbea:nbox_003
        description = S("Steel Frame with Glowing Core"),
        tiles = {
            {
                animation = {
                    type = "vertical_frames",
                    aspect_w = 16,
                    aspect_h = 16,
                    length = 4.0
                },
                backface_culling = false,
                image = "unilib_misc_frame_steel_with_core_animated.png",
            }
        },
        groups = {cracky = 3},
        sounds = unilib.node_sound_metal_defaults({
            footstep = {name = "unilib_glass_footstep", gain = 0.5},
            dug = {name = "unilib_break_glass", gain = 1.0},
        }),

        drawtype = "nodebox",
        is_ground_content = false,
        light_source = 8,
        node_box = {
            type = "fixed",
            fixed = {
                -- Corner frame
                {-0.5, 0.4375, -0.4375, -0.4375, 0.5, 0.4375},
                {-0.5, -0.5, -0.4375, -0.4375, -0.4375, 0.4375},
                {-0.5, -0.5, -0.5, -0.4375, 0.5, -0.4375},
                {-0.5, -0.5, 0.4375, -0.4375, 0.5, 0.5},
                {-0.4375, 0.4375, -0.5, 0.4375, 0.5, -0.4375},
                {-0.4375, -0.5, -0.5, 0.4375, -0.4375, -0.4375},
                {-0.4375, 0.4375, 0.4375, 0.4375, 0.5, 0.5},
                {-0.4375, -0.5, 0.4375, 0.4375, -0.4375, 0.5},
                {0.4375, 0.4375, -0.5, 0.5, 0.5, 0.5},
                {0.4375, -0.5, -0.5, 0.5, -0.4375, 0.5},
                {0.4375, -0.4375, 0.4375, 0.5, 0.4375, 0.5},
                {0.4375, -0.4375, -0.5, 0.5, 0.4375, -0.4375},
                -- Centre mass 2px--0.0625 / 4px--0.125 / 6px--0.1875
                {-0.125, -0.125, -0.125, 0.125, 0.125, 0.125},
            },
        },
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
            },
        },
        sunlight_propagates = true,
        use_texture_alpha = "clip",
    })
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:misc_frame_steel_with_core",
        recipe = {
            {c_steel, "", c_steel},
            {"", "unilib:mineral_mese_crystal", ""},
            {c_steel, "", c_steel},
        },
    })

    if minetest.get_modpath("mesecons") then

        unilib.override_item("unilib:misc_frame_steel_with_core", {
            groups = {cracky = 3, mesecon = 3, mesecon_effector_off = 1},

            light_source = 5,
            mesecons = {
                effector = {
                    rules = rules_table,

                    action_on = function(pos, node)

                        minetest.swap_node(
                            pos,
                            {name = "unilib:misc_frame_steel_with_core_on", param2 = node.param2}
                        )

                    end,
                },
            },
        })

        unilib.register_node("unilib:misc_frame_steel_with_core_on", "nbea:nbox_003_on", mode, {
            -- From nbea:nbox_003_on
            description = S("Steel Frame with Glowing Core"),
            tiles = {
                {
                    animation = {
                        type = "vertical_frames",
                        aspect_w = 16,
                        aspect_h = 16,
                        length = 1.25
                    },
                    backface_culling = false,
                    image = "unilib_misc_frame_steel_with_core_animated.png",
                }
            },
            groups = {cracky = 3, mesecon = 2, not_in_creative_inventory = 1},
            sounds = unilib.node_sound_metal_defaults({
                footstep = {name = "unilib_glass_footstep", gain = 0.5},
                dug = {name = "unilib_break_glass", gain = 1.0},
            }),

            drawtype = "nodebox",
            drop = "unilib:misc_frame_steel_with_core",
            is_ground_content = false,
            light_source = 8,
            mesecons = {
                effector = {
                    rules = rules_table,

                    action_off = function(pos, node)

                        minetest.swap_node(
                            pos,
                            {name = "unilib:misc_frame_steel_with_core", param2 = node.param2}
                        )

                    end,
                },
            },
            node_box = {
                type = "fixed",
                fixed = {
                    -- Corner frame
                    {-0.5, 0.4375, -0.4375, -0.4375, 0.5, 0.4375},
                    {-0.5, -0.5, -0.4375, -0.4375, -0.4375, 0.4375},
                    {-0.5, -0.5, -0.5, -0.4375, 0.5, -0.4375},
                    {-0.5, -0.5, 0.4375, -0.4375, 0.5, 0.5},
                    {-0.4375, 0.4375, -0.5, 0.4375, 0.5, -0.4375},
                    {-0.4375, -0.5, -0.5, 0.4375, -0.4375, -0.4375},
                    {-0.4375, 0.4375, 0.4375, 0.4375, 0.5, 0.5},
                    {-0.4375, -0.5, 0.4375, 0.4375, -0.4375, 0.5},
                    {0.4375, 0.4375, -0.5, 0.5, 0.5, 0.5},
                    {0.4375, -0.5, -0.5, 0.5, -0.4375, 0.5},
                    {0.4375, -0.4375, 0.4375, 0.5, 0.4375, 0.5},
                    {0.4375, -0.4375, -0.5, 0.5, 0.4375, -0.4375},
                    -- Centre mass 2px--0.0625 / 4px--0.125 / 6px--0.1875
                    {-0.0625, -0.0625, -0.0625, 0.0625, 0.0625, 0.0625},
                },
            },
            paramtype = "light",
            selection_box = {
                type = "fixed",
                fixed = {
                    {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
                },
            },
            sunlight_propagates = true,
            use_texture_alpha = "clip",
        })

        unilib.register_abm({
            label = "Steel frame particles [misc_frame_steel_with_core]",
            nodenames = {"unilib:misc_frame_steel_with_core_on"},

            catch_up = false,
            chance = 1,
            interval = 1,

            action = function(pos, node)

                minetest.add_particlespawner({
                    amount = 50,
                    time = 1,

                    collisiondetection = true,
                    collision_removal = true,
                    glow = 10,
                    maxacc = {x = 1.0, y = 1.0, z = 1.0},
                    minacc = {x = -0.1,  y = -0.1,  z = -0.1},
                    maxexptime = 0.15,
                    minexptime = 0.05,
                    maxpos = {x = pos.x + 0.15, y = pos.y + 0.15, z = pos.z + 0.15},
                    minpos = {x = pos.x - 0.15, y = pos.y - 0.15, z = pos.z - 0.15},
                    maxsize = 0.15,
                    minsize = 0.15,
                    maxvel = {x = 0.005, y = 0.005, z = 0.005},
                    minvel = {x = -0.01, y = -0.02, z = -0.01},
                    texture = "unilib_misc_core_particle.png",
                })

            end
        })

    end

end
