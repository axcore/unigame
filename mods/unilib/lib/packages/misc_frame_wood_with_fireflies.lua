---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    nbea
-- Code:    WTFPL
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_frame_wood_with_fireflies = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.nbea.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_frame_wood_with_fireflies.init()

    return {
        description = "Wood-framed glass with fireflies",
        depends = {"item_stick_ordinary", "vessel_bottle_glass_with_firefly"},
    }

end

function unilib.pkg.misc_frame_wood_with_fireflies.exec()

    local c_stick = "unilib:item_stick_ordinary"

    unilib.register_node("unilib:misc_frame_wood_with_fireflies", "nbea:nbox_008", mode, {
        -- From nbea:nbox_008
        description = S("Wood-Framed Glass with Fireflies"),
        tiles = {"unilib_misc_frame_wood_overlay.png"},
        groups = {choppy = 3, oddly_breakable_by_hand = 3},
        sounds = unilib.node_sound_wood_defaults({
            footstep = {name = "unilib_glass_footstep", gain = 0.5},
            dug = {name = "unilib_break_glass", gain = 1.0},
        }),

        collision_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
            },
        },
        drawtype = "nodebox",
        -- N.B. inventory_image removed from original code
--      inventory_image = "unilib_misc_frame_wood_with_fireflies_inv.png",
        is_ground_content = false,
        light_source = 3,
        node_box = {
            type = "fixed",
            fixed = {
                {-0.4375, 0.4375, 0.4375, 0.4375, 0.5, 0.5},
                {-0.4375, -0.5, 0.4375, 0.4375, -0.4375, 0.5},
                {-0.5, -0.5, 0.4375, -0.4375, 0.5, 0.5},
                {0.4375, -0.5, 0.4375, 0.5, 0.5, 0.5},
                {-0.5, 0.4375, -0.4375, -0.4375, 0.5, 0.4375},
                {-0.5, -0.5, -0.4375, -0.4375, -0.4375, 0.4375},
                {0.4375, 0.4375, -0.4375, 0.5, 0.5, 0.4375},
                {0.4375, -0.5, -0.4375, 0.5, -0.4375, 0.4375},
                {-0.5, 0.4375, -0.5, 0.5, 0.5, -0.4375},
                {-0.5, -0.5, -0.5, 0.5, -0.4375, -0.4375},
                {0.4375, -0.4375, -0.5, 0.5, 0.4375, -0.4375},
                {-0.5, -0.4375, -0.5, -0.4375, 0.4375, -0.4375},
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
        wield_image = "unilib_misc_frame_wood_with_fireflies_inv.png",

        after_destruct = function(pos)

            minetest.add_particle({
                acc = {x = 0.010, y = 0.025, z = 0.010},
                collisiondetection = true,
                expirationtime = 5,
                glow = 8,
                maxsize = 2,
                minsize = 1,
                pos = {x = pos.x, y = pos.y, z = pos.z},
                texture = "unilib_misc_firefly_particle_1.png",
                vel = {x = 0.25, y = 0.05, z = 0.25},
            })

        end,
    })

    unilib.register_abm({
        label = "Wood frame particles [misc_frame_wood_with_fireflies]",
        nodenames = {"unilib:misc_frame_wood_with_fireflies"},

        catch_up = false,
        chance = 3,
        interval = 1,

        action = function(pos, node)

            local num = math.random(4)

            minetest.add_particlespawner({
                amount = 6,
                time = 3,

                collisiondetection = true,
                collision_removal = true,
                glow = 8,
                maxacc = {x = 0.015, y = 0.05, z = 0.015},
                minacc = {x = -0.125, y = -0.15, z = -0.125},
                maxexptime = 1.75,
                minexptime = 1.0,
                maxpos = {x = pos.x + 0.175, y = pos.y + 0.350, z = pos.z + 0.175},
                minpos = {x = pos.x - 0.175, y = pos.y - 0.350, z = pos.z - 0.175},
                maxsize = 1.5,
                minsize = 0.5,
                maxvel = {x = 0.001, y = 0.001, z = 0.001},
                minvel = {x = -0.01, y = -0.02, z = -0.01},
                texture = "unilib_misc_firefly_particle_" .. num .. ".png",
            })

        end,
    })
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:misc_frame_wood_with_fireflies",
        recipe = {
            {c_stick, "", c_stick},
            {"", "unilib:vessel_bottle_glass_with_firefly", ""},
            {c_stick, "", c_stick},
        },
    })

end
