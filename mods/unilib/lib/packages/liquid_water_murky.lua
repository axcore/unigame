---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr6
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.liquid_water_murky = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.glemr6.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.liquid_water_murky.init()

    return {
        description = "Murky water",
    }

end

function unilib.pkg.liquid_water_murky.exec()

    -- (Creates unilib:bucket_steel_with_water_murky, etc)
    unilib.register_liquid({
        part_name = "water_murky",
        source_name = "unilib:liquid_water_murky_source",
        flowing_name = "unilib:liquid_water_murky_flowing",

        burntime = 0,
        description = S("Murky Water"),
        water_flag = true,
    })

    unilib.register_node(
        -- From GLEMr6, lib_materials:fluid_water_murky_source
        "unilib:liquid_water_murky_source",
        "lib_materials:fluid_water_murky_source",
        mode,
        {
            description = S("Murky Water Source"),
            tiles = {
                {
                    name = "unilib_liquid_water_ordinary_source_animated.png" ..
                            "^[colorize:#1F1F00:alpha",
                    animation = {
                        type = "vertical_frames",
                        aspect_w = 16,
                        aspect_h = 16,
                        length = 2.0,
                    },
                },
            },
            groups = {cools_lava = 1, liquid = 3, puts_out_fire = 1, water = 3},
            sounds = unilib.global.sound_table.water,

            buildable_to = true,
            diggable = false,
            drawtype = "liquid",
            drop = "",
            drowning = 1,
            is_ground_content = false,
            liquid_alternative_flowing = "unilib:liquid_water_murky_flowing",
            liquid_alternative_source = "unilib:liquid_water_murky_source",
            liquid_viscosity = 1,
            liquidtype = "source",
            paramtype = "light",
            pointable = false,
            post_effect_color = {r = 30, g = 60, b = 90, a = 103},
            special_tiles = {
                {
                    name = "unilib_liquid_water_ordinary_source_animated.png" ..
                            "^[colorize:#1F1F00:alpha",
                    animation = {
                        type = "vertical_frames",
                        aspect_w = 16,
                        aspect_h = 16,
                        length = 2.0,
                    },
                    backface_culling = false,
                },
            },
            use_texture_alpha = "blend",
            walkable = false,
        }
    )

    unilib.register_node(
        -- From lib_materials:fluid_water_murky_flowing
        "unilib:liquid_water_murky_flowing",
        "lib_materials:fluid_water_murky_flowing",
        mode,
        {
            description = S("Murky Flowing Water"),
            tiles = {"unilib_liquid_water_ordinary.png^[colorize:#1F1F00:alpha"},
            groups = {
                cools_lava = 1, liquid = 3, not_in_creative_inventory = 1, puts_out_fire = 1,
                water = 3,
            },
            sounds = unilib.global.sound_table.water,

            buildable_to = true,
            diggable = false,
            drawtype = "flowingliquid",
            drop = "",
            drowning = 1,
            is_ground_content = false,
            liquid_alternative_flowing = "unilib:liquid_water_murky_flowing",
            liquid_alternative_source = "unilib:liquid_water_murky_source",
            liquid_viscosity = 1,
            liquidtype = "flowing",
            paramtype = "light",
            paramtype2 = "flowingliquid",
            pointable = false,
            post_effect_color = {r = 30, g = 60, b = 90, a = 103},
            special_tiles = {
                {
                    name = "unilib_liquid_water_ordinary_flowing_animated.png" ..
                            "^[colorize:#1F1F00:alpha",
                    animation = {
                        type = "vertical_frames",
                        aspect_w = 16,
                        aspect_h = 16,
                        length = 0.8,
                    },
                    backface_culling = false,
                },
                {
                    name = "unilib_liquid_water_ordinary_flowing_animated.png" ..
                            "^[colorize:#1F1F00:alpha",
                    animation = {
                        type = "vertical_frames",
                        aspect_w = 16,
                        aspect_h = 16,
                        length = 0.8,
                    },
                    backface_culling = true,
                },
            },
            use_texture_alpha = "blend",
            walkable = false,
        }
    )

end
