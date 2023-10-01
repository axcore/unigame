---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.liquid_mud_boiling = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.liquid_mud_boiling.init()

    return {
        description = "Boiling mud",
        depends = "sand_silt_antipodean",
    }

end

function unilib.pkg.liquid_mud_boiling.exec()

    -- (Original to unilib. Creates unilib:bucket_steel_with_mud_boiling, etc)
    unilib.register_liquid({
        part_name = "mud_boiling",
        source_name = "unilib:liquid_mud_boiling_source",
        flowing_name = "unilib:liquid_mud_boiling_flowing",

        -- (Setting burntime to not-zero prevents its use in wooden buckets, etc)
        burntime = 5,
        description = S("Boiling Mud"),
        -- (Same values as in the liquid_lava_ordinary package)
        force_renew_flag = false,
    })

    unilib.register_node("unilib:liquid_mud_boiling_source", "aotearoa:boiling_mud_source", mode, {
        -- From aotearoa:boiling_mud_source
        description = S("Boiling Mud Source"),
        tiles = {
            {
                name = "unilib_liquid_mud_boiling_source_animated.png",
                animation = {
                    type = "vertical_frames",
                    aspect_w = 16,
                    aspect_h = 16,
                    length = 3.0,
                },
            },
        },
        groups = {liquid = 2},
        sounds = unilib.node_sound_dirt_defaults({
            footstep = {name = "unilib_dirt_mud_antipodean", gain = 0.4},
            dug = {name = "unilib_dirt_mud_antipodean", gain = 0.4},
        }),

        buildable_to = true,
        damage_per_second = 1,
        diggable = false,
        drawtype = "liquid",
        drop = "unilib:sand_silt_antipodean",
        drowning = 1,
        is_ground_content = false,
        liquid_alternative_flowing = "unilib:liquid_mud_boiling_flowing",
        liquid_alternative_source = "unilib:liquid_mud_boiling_source",
        liquid_renewable = false,
        liquid_viscosity = 7,
        liquidtype = "source",
        paramtype = "light",
        pointable = false,
        post_effect_color = {r = 73, g = 64, b = 55, a = 200},
        special_tiles = {
            {
                name = "unilib_liquid_mud_boiling_source_animated.png",
                animation = {
                    type = "vertical_frames",
                    aspect_w = 16,
                    aspect_h = 16,
                    length = 3.0,
                },
                backface_culling = false,
            },
        },
        walkable = false,
    })

    unilib.register_node(
        -- From aotearoa:boiling_mud_flowing
        "unilib:liquid_mud_boiling_flowing",
        "aotearoa:boiling_mud_flowing",
        mode,
        {
            description = S("Flowing Boiling Mud"),
            tiles = {"unilib_liquid_mud_boiling_flowing.png"},
            groups = {liquid = 2, not_in_creative_inventory = 1},
            sounds = unilib.node_sound_dirt_defaults({
                footstep = {name = "unilib_dirt_mud_antipodean", gain = 0.4},
                dug = {name = "unilib_dirt_mud_antipodean", gain = 0.4},
            }),

            buildable_to = true,
            damage_per_second = 1,
            diggable = false,
            drawtype = "flowingliquid",
            drop = "",
            drowning = 1,
            is_ground_content = false,
            liquid_alternative_flowing = "unilib:liquid_mud_boiling_flowing",
            liquid_alternative_source = "unilib:liquid_mud_boiling_source",
            liquid_range = 2,
            liquid_renewable = false,
            liquid_viscosity = 7,
            liquidtype = "flowing",
            paramtype = "light",
            paramtype2 = "flowingliquid",
            pointable = false,
            post_effect_color = {r = 73, g = 64, b = 55, a = 200},
            special_tiles = {
                {
                    name = "unilib_liquid_mud_boiling_flowing_animated.png",
                    backface_culling = false,
                    animation = {
                        type = "vertical_frames",
                        aspect_w = 16,
                        aspect_h = 16,
                        length = 3.3,
                    },
                },
                {
                    name = "unilib_liquid_mud_boiling_flowing_animated.png",
                    backface_culling = true,
                    animation = {
                        type = "vertical_frames",
                        aspect_w = 16,
                        aspect_h = 16,
                        length = 3.3,
                    },
                },
            },
            walkable = false,
        }
    )

end
