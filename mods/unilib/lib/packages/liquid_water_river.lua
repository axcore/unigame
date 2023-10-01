---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.liquid_water_river = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.liquid_water_river.init()

    return {
        description = "River water",
    }

end

function unilib.pkg.liquid_water_river.exec()

    -- (Creates unilib:bucket_steel_with_water_river, etc)
    unilib.register_liquid({
        part_name = "water_river",
        source_name = "unilib:liquid_water_river_source",
        flowing_name = "unilib:liquid_water_river_flowing",

        burntime = 0,
        craftable_flag = true,
        description = S("River Water"),
        -- (See notes from default below)
        force_renew_flag = true,
        potable_flag = true,
        water_flag = true,
    })

    unilib.register_node(
        -- From default:river_water_source
        "unilib:liquid_water_river_source",
        "default:river_water_source",
        mode,
        {
            description = S("River Water Source"),
            tiles = {
                {
                    name = "unilib_liquid_water_river_source_animated.png",
                    animation = {
                        type = "vertical_frames",
                        aspect_w = 16,
                        aspect_h = 16,
                        length = 2.0,
                    },
                    backface_culling = false,
                },
                {
                    name = "unilib_liquid_water_river_source_animated.png",
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
            liquid_alternative_flowing = "unilib:liquid_water_river_flowing",
            liquid_alternative_source = "unilib:liquid_water_river_source",
            liquid_range = 2,
            -- Notes from default:
            -- Not renewable to avoid horizontal spread of water sources in sloping rivers that can
            --      cause water to overflow riverbanks and cause floods
            -- River water source is instead made renewable by the 'force renew' option used in the
            --      'bucket' mod by the river water bucket
            liquid_renewable = false,
            liquid_viscosity = 1,
            liquidtype = "source",
            paramtype = "light",
            pointable = false,
            post_effect_color = {r = 30, g = 76, b = 90, a = 103},
            use_texture_alpha = "blend",
            walkable = false,
        }
    )

    unilib.register_node(
        "unilib:liquid_water_river_flowing",
        "default:river_water_flowing",
        mode,
        {
            -- From default:river_water_flowing
            description = S("Flowing River Water"),
            tiles = {"unilib_liquid_water_river.png"},
            groups = {cools_lava = 1, liquid = 3, not_in_creative_inventory = 1, water = 3},
            sounds = unilib.sound_table.water,

            buildable_to = true,
            diggable = false,
            drawtype = "flowingliquid",
            drop = "",
            drowning = 1,
            is_ground_content = false,
            liquid_alternative_flowing = "unilib:liquid_water_river_flowing",
            liquid_alternative_source = "unilib:liquid_water_river_source",
            liquid_range = 2,
            liquid_renewable = false,
            liquid_viscosity = 1,
            liquidtype = "flowing",
            paramtype = "light",
            paramtype2 = "flowingliquid",
            pointable = false,
            post_effect_color = {r = 30, g = 76, b = 90, a = 103},
            special_tiles = {
                {
                    name = "unilib_liquid_water_river_flowing_animated.png",
                    animation = {
                        type = "vertical_frames",
                        aspect_w = 16,
                        aspect_h = 16,
                        length = 0.5,
                    },
                    backface_culling = false,
                },
                {
                    name = "unilib_liquid_water_river_flowing_animated.png",
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
        }
    )

end
