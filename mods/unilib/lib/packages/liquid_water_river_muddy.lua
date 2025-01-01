---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.liquid_water_river_muddy = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.liquid_water_river_muddy.init()

    return {
        description = "Muddy river water",
    }

end

function unilib.pkg.liquid_water_river_muddy.exec()

    -- (Creates unilib:bucket_steel_with_water_river_muddy, etc)
    unilib.register_liquid({
        part_name = "water_river_muddy",
        source_name = "unilib:liquid_water_river_muddy_source",
        flowing_name = "unilib:liquid_water_river_muddy_flowing",

        burntime = 0,
        craftable_flag = true,
        description = S("Muddy River Water"),
        force_renew_flag = false,
        water_flag = true,
    })

    unilib.register_node(
        -- From australia:muddy_river_water_source
        "unilib:liquid_water_river_muddy_source",
        "australia:muddy_river_water_source",
        mode,
        {
            description = S("Muddy River Water Source"),
            tiles = {
                {
                    name = "unilib_liquid_water_river_muddy_flowing_animated.png",
                    animation = {
                        type = "vertical_frames",
                        aspect_w = 16,
                        aspect_h = 16,
                        length = 2.0,
                    },
                },
            },
            groups = {liquid = 3, puts_out_fire = 1, water = 3},
            -- N.B. no sounds in original code
            sounds = unilib.global.sound_table.water,

            buildable_to = true,
            diggable = false,
            drawtype = "liquid",
            drop = "",
            drowning = 1,
            is_ground_content = false,
            liquid_alternative_flowing = "unilib:liquid_water_river_muddy_flowing",
            liquid_alternative_source = "unilib:liquid_water_river_muddy_source",
            liquid_range = 3,
            liquid_renewable = true,
            liquid_viscosity = 1,
            liquidtype = "source",
            paramtype = "light",
            pointable = false,
            post_effect_color = {r = 92, g = 80, b = 48, a = 232},
            special_tiles = {
                {
                    name = "unilib_liquid_water_river_muddy_flowing_animated.png",
                    animation = {
                        type = "vertical_frames",
                        aspect_w = 16,
                        aspect_h = 16,
                        length = 2.0,
                    },
                    backface_culling = false,
                },
            },
            -- N.B. In original code, "alpha = 224" (obsolete)
            use_texture_alpha = "blend",
            walkable = false,
        }
    )

    unilib.register_node(
        -- From australia:muddy_river_water_flowing
        "unilib:liquid_water_river_muddy_flowing",
        "australia:muddy_river_water_flowing",
        mode,
        {
            description = S("Flowing Muddy River Water"),
            tiles = {"unilib_liquid_water_river_muddy_source.png"},
            groups = {liquid = 3, not_in_creative_inventory = 1, puts_out_fire = 1, water = 3},
            -- N.B. no sounds in original code
            sounds = unilib.global.sound_table.water,

            buildable_to = true,
            diggable = false,
            drawtype = "flowingliquid",
            drop = "",
            drowning = 1,
            is_ground_content = false,
            liquid_alternative_flowing = "unilib:liquid_water_river_muddy_flowing",
            liquid_alternative_source = "unilib:liquid_water_river_muddy_source",
            liquid_range = 3,
            liquid_renewable = true,
            liquid_viscosity = 1,
            liquidtype = "flowing",
            paramtype = "light",
            paramtype2 = "flowingliquid",
            pointable = false,
            post_effect_color = {r = 92, g = 80, b = 48, a = 232},
            special_tiles = {
                {
                    image = "unilib_liquid_water_river_muddy_flowing_animated.png",
                    backface_culling = false,
                    animation = {
                        type = "vertical_frames",
                        aspect_w = 16,
                        aspect_h = 16,
                        length = 0.8,
                    },
                },
                {
                    image = "unilib_liquid_water_river_muddy_flowing_animated.png",
                    backface_culling = true,
                    animation = {
                        type = "vertical_frames",
                        aspect_w = 16,
                        aspect_h = 16,
                        length = 0.8,
                    },
                },
            },
            -- N.B. In original code, "alpha = 224" (obsolete)
            use_texture_alpha = "blend",
            walkable = false,
        }
    )

end
