---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.liquid_water_ordinary = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.liquid_water_ordinary.init()

    return {
        description = "Ordinary water",
    }

end

function unilib.pkg.liquid_water_ordinary.exec()

    -- (Creates unilib:bucket_steel_with_water_ordinary, etc)
    unilib.register_liquid({
        part_name = "water_ordinary",
        source_name = "unilib:liquid_water_ordinary_source",
        flowing_name = "unilib:liquid_water_ordinary_flowing",

        burntime = 0,
        craftable_flag = true,
        description = S("Ordinary Water"),
        force_renew_flag = false,
        potable_flag = true,
        water_flag = true,
    })

    unilib.register_node(
        -- From default:water_source
        "unilib:liquid_water_ordinary_source",
        "default:water_source",
        mode,
        {
            description = S("Ordinary Water Source"),
            tiles = {
                {
                    name = "unilib_liquid_water_ordinary_source_animated.png",
                    animation = {
                        type = "vertical_frames",
                        aspect_w = 16,
                        aspect_h = 16,
                        length = 2.0,
                    },
                    backface_culling = false,
                },
                {
                    name = "unilib_liquid_water_ordinary_source_animated.png",
                    animation = {
                        type = "vertical_frames",
                        aspect_w = 16,
                        aspect_h = 16,
                        length = 2.0,
                    },
                    backface_culling = true,
                },
            },
            groups = {cools_lava = 1, liquid = 3, water = 3},
            sounds = unilib.sound_table.water,

            buildable_to = true,
            diggable = false,
            drawtype = "liquid",
            drop = "",
            drowning = 1,
            is_ground_content = false,
            liquid_alternative_flowing = "unilib:liquid_water_ordinary_flowing",
            liquid_alternative_source = "unilib:liquid_water_ordinary_source",
            liquid_viscosity = 1,
            liquidtype = "source",
            paramtype = "light",
            pointable = false,
            post_effect_color = {r = 30, g = 60, b = 90, a = 103},
            use_texture_alpha = "blend",
            walkable = false,
            waving = 3,
        }
    )

    unilib.register_node(
        -- From default:water_flowing
        "unilib:liquid_water_ordinary_flowing",
        "default:water_flowing",
        mode,
        {
            description = S("Flowing Ordinary Water"),
            tiles = {"unilib_liquid_water_ordinary.png"},
            groups = {cools_lava = 1, liquid = 3, not_in_creative_inventory = 1, water = 3},
            sounds = unilib.sound_table.water,

            buildable_to = true,
            diggable = false,
            drawtype = "flowingliquid",
            drop = "",
            drowning = 1,
            is_ground_content = false,
            liquid_alternative_flowing = "unilib:liquid_water_ordinary_flowing",
            liquid_alternative_source = "unilib:liquid_water_ordinary_source",
            liquid_viscosity = 1,
            liquidtype = "flowing",
            paramtype = "light",
            paramtype2 = "flowingliquid",
            pointable = false,
            post_effect_color = {r = 30, g = 60, b = 90, a = 103},
            special_tiles = {
                {
                    name = "unilib_liquid_water_ordinary_flowing_animated.png",
                    animation = {
                        type = "vertical_frames",
                        aspect_w = 16,
                        aspect_h = 16,
                        length = 0.5,
                    },
                    backface_culling = false,
                },
                {
                    name = "unilib_liquid_water_ordinary_flowing_animated.png",
                    animation = {
                        type = "vertical_frames",
                        aspect_w = 16,
                        aspect_h = 16,
                        length = 0.5,
                    },
                    backface_culling = true,
                },
            },
            use_texture_alpha = "blend",
            walkable = false,
            waving = 3,
        }
    )

end
