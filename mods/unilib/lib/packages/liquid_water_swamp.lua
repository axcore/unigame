---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr11
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.liquid_water_swamp = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.glemr11.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.liquid_water_swamp.init()

    return {
        description = "Swamp water",
    }

end

function unilib.pkg.liquid_water_swamp.exec()

    -- (Creates unilib:bucket_steel_with_water_swamp, etc)
    unilib.register_liquid({
        part_name = "water_swamp",
        source_name = "unilib:liquid_water_swamp_source",
        flowing_name = "unilib:liquid_water_swamp_flowing",

        burntime = 0,
        description = S("Swamp Water"),
        water_flag = true,
    })

    unilib.register_node(
        -- From GLEMr11, lib_materials:fluid_water_swamp_source
        "unilib:liquid_water_swamp_source",
        "lib_materials:liquid_water_swamp_source",
        mode,
        {
            description = S("Swamp Water Source"),
            tiles = {
                {
                    name = "unilib_liquid_water_swamp_source_animated.png",
                    animation = {
                        type = "vertical_frames",
                        length = 1.5,
                        aspect_h = 16,
                        aspect_w = 16,
                    },
                    backface_culling = false,
                },
                {
                    name = "unilib_liquid_water_swamp_source_animated.png",
                    animation = {
                        type = "vertical_frames",
                        length = 1.5,
                        aspect_h = 16,
                        aspect_w = 16,
                    },
                    backface_culling = true,
                },
            },
            groups = {cools_lava = 1, liquid = 2, puts_out_fire = 1, water = 3},
            sounds = unilib.sound_table.water,

            buildable_to = true,
            diggable = false,
            drawtype = "liquid",
            drowning = 1,
            liquid_alternative_flowing = "unilib:liquid_water_swamp_flowing",
            liquid_alternative_source = "unilib:liquid_water_swamp_source",
            liquid_range = 3,
            liquid_renewable = false,
            liquid_viscosity = 1,
            liquidtype = "source",
            paramtype = "light",
            pointable = false,
            use_texture_alpha = "blend",
            walkable = false,
        }
    )

    unilib.register_node(
        -- From GLEMr11, lib_materials:liquid_water_swamp_flowing
        "unilib:liquid_water_swamp_flowing",
        "lib_materials:liquid_water_swamp_flowing",
        mode,
        {
            description = S("Flowing Swamp Water"),
            tiles = {"unilib_liquid_water_swamp_source.png"},
            groups = {
                cools_lava = 1, liquid = 2, not_in_creative_inventory = 1, puts_out_fire = 1,
                water = 3,
            },
            sounds = unilib.sound_table.water,

            buildable_to = true,
            diggable = false,
            drawtype = "flowingliquid",
            drowning = 1,
            liquid_alternative_flowing = "unilib:liquid_water_swamp_flowing",
            liquid_alternative_source = "unilib:liquid_water_swamp_source",
            liquid_range = 3,
            liquidtype = "flowing",
            liquid_renewable = false,
            liquid_viscosity = 1,
            paramtype = "light",
            paramtype2 = "flowingliquid",
            pointable = false,
            special_tiles = {
                {
                    name = "unilib_liquid_water_swamp_flowing_animated.png",
                    animation = {
                        type = "vertical_frames",
                        length = 1.5,
                        aspect_h = 16,
                        aspect_w = 16,
                    },
                    backface_culling = false,
                },
                {
                    name = "unilib_liquid_water_swamp_flowing_animated.png",
                    animation = {
                        type = "vertical_frames",
                        length = 1.5,
                        aspect_h = 16,
                        aspect_w = 16,
                    },
                    backface_culling = true,
                },
            },
            use_texture_alpha = "blend",
            walkable = false,
        }
    )

end
