---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.liquid_water_dyed = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

-- Basic dyed water set
local water_list = {
    {
        "black",
        S("Black Dyed Water"),
        S("Black Dyed Water Source"),
        S("Flowing Black Dyed Water"),
        "#0C0C0C",
    },
    {
        "blue",
        S("Blue Dyed Water"),
        S("Blue Dyed Water Source"),
        S("Flowing Blue Dyed Water"),
        "#0000FF",
    },
    {
        "brown",
        S("Brown Dyed Water"),
        S("Brown Dyed Water Source"),
        S("Flowing Brown Dyed Water"),
        "#A52A2A",
    },
    {
        "cyan",
        S("Cyan Dyed Water"),
        S("Cyan Dyed Water Source"),
        S("Flowing Cyan Dyed Water"),
        "#00FFFF",
    },
    {
        "green",
        S("Green Dyed Water"),
        S("Green Dyed Water Source"),
        S("Flowing Green Dyed Water"),
        "#008000",
    },
    {
        "green_dark",
        S("Dark Green Dyed Water"),
        S("Dark Green Dyed Water Source"),
        S("Flowing Dark Green Dyed Water"),
        "#002600",
    },
    {
        "grey",
        S("Grey Dyed Water"),
        S("Grey Dyed Water Source"),
        S("Flowing Grey Dyed Water"),
        "#808080",
    },
    {
        "grey_dark",
        S("Dark Grey Dyed Water"),
        S("Dark Grey Dyed Water Source"),
        S("Flowing Dark Grey Dyed Water"),
        "#3C3C3C",
    },
    {
        "magenta",
        S("Magenta Dyed Water"),
        S("Magenta Dyed Water Source"),
        S("Flowing Magenta Dyed Water"),
        "#FF00FF",
    },
    {
        "orange",
        S("Orange Dyed Water"),
        S("Orange Dyed Water Source"),
        S("Flowing Orange Dyed Water"),
        "#FFA500",
    },
    {
        "pink",
        S("Pink Dyed Water"),
        S("Pink Dyed Water Source"),
        S("Flowing Pink Dyed Water"),
        "#FFC0CB",
    },
    {
        "red",
        S("Red Dyed Water"),
        S("Red Dyed Water Source"),
        S("Flowing Red Dyed Water"),
        "#FF0000",
    },
    {
        "violet",
        S("Violet Dyed Water"),
        S("Violet Dyed Water Source"),
        S("Flowing Violet Dyed Water"),
        "#EE82EE",
    },
    {
        "white",
        S("White Dyed Water"),
        S("White Dyed Water Source"),
        S("Flowing White Dyed Water"),
        "#FFFFFF",
    },
    {
        "yellow",
        S("Yellow Dyed Water"),
        S("Yellow Dyed Water Source"),
        S("Flowing Yellow Dyed Water"),
        "#FFFF00",
    },
}

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.liquid_water_dyed.init()

    return {
        description = "Dyed water set (15 colours)",
        depends = "dye_basic",
    }

end

function unilib.pkg.liquid_water_dyed.exec()

    for _, row_list in ipairs(water_list) do

        local part_name = row_list[1]
        local generic_description = row_list[2]
        local source_description = row_list[3]
        local flowing_description = row_list[4]
        local rgb = row_list[5]

        local source_name = "unilib:liquid_water_dyed_" .. part_name .. "_source"
        local flowing_name = "unilib:liquid_water_dyed_" .. part_name .. "_flowing"
        local alpha = 196

        -- (Creates unilib:bucket_steel_with_water_dyed_black, etc)
        unilib.register_liquid({
            part_name = "water_dyed_" ..part_name,
            source_name = source_name,
            flowing_name = flowing_name,

            burntime = 0,
            description = generic_description,
            force_renew_flag = false,
            water_flag = true,
        })

        unilib.register_node(source_name, nil, mode, {
            -- Original to unilib, code adpated from unilib:liquid_water_ordinary_source
            description = source_description,
            tiles = {
                {
                    name = "unilib_liquid_water_dyed_source_animated.png^[colorize:" .. rgb ..
                           ":" .. alpha,
                    animation = {
                        type = "vertical_frames",
                        aspect_w = 16,
                        aspect_h = 16,
                        length = 2.0,
                    },
                    backface_culling = false,
                },
                {
                    name = "unilib_liquid_water_dyed_source_animated.png^[colorize:" .. rgb ..
                           ":" .. alpha,
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
            sounds = unilib.global.sound_table.water,

            buildable_to = true,
            diggable = false,
            drawtype = "liquid",
            drop = "",
            drowning = 1,
            is_ground_content = false,
            liquid_alternative_flowing = flowing_name,
            liquid_alternative_source = source_name,
            liquid_viscosity = 1,
            liquidtype = "source",
            paramtype = "light",
            pointable = false,
            post_effect_color = {r = 30, g = 60, b = 90, a = 103},
            use_texture_alpha = "blend",
            walkable = false,
            waving = 3,
        })

        unilib.register_node(flowing_name, nil, mode, {
            -- Original to unilib, code adpated from unilib:liquid_water_ordinary_flowing
             description = flowing_description,
             tiles = {"unilib_liquid_water_dyed.png^[multiply:" .. rgb .. ":100"},
             groups = {cools_lava = 1, liquid = 3, not_in_creative_inventory = 1, water = 3},
             sounds = unilib.global.sound_table.water,

             buildable_to = true,
             diggable = false,
             drawtype = "flowingliquid",
             drop = "",
             drowning = 1,
             is_ground_content = false,
             liquid_alternative_flowing = flowing_name,
             liquid_alternative_source = source_name,
             liquid_viscosity = 1,
             liquidtype = "flowing",
             paramtype = "light",
             paramtype2 = "flowingliquid",
             pointable = false,
             post_effect_color = {r = 30, g = 60, b = 90, a = 103},
             special_tiles = {
                 {
                     name = "unilib_liquid_water_dyed_flowing_animated.png^[colorize:" .. rgb ..
                            ":" .. alpha,
                     animation = {
                         type = "vertical_frames",
                         aspect_w = 16,
                         aspect_h = 16,
                         length = 0.5,
                     },
                     backface_culling = false,
                 },
                 {
                     name = "unilib_liquid_water_dyed_flowing_animated.png^[colorize:" .. rgb ..
                            ":" .. alpha,
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
         })

    end

end

function unilib.pkg.liquid_water_dyed.post()

    for _, row_list in ipairs(water_list) do

        local part_name = row_list[1]

        for bucket_type, _ in pairs(unilib.global.generic_bucket_table) do

            local c_water_bucket = "unilib:" .. bucket_type .. "_with_water_ordinary"
            local c_dyed_bucket = "unilib:" .. bucket_type .. "_with_water_dyed_" .. part_name

            unilib.register_craft({
                -- Original to unilib
                type = "shapeless",
                output = c_dyed_bucket,
                recipe = {c_water_bucket, "unilib:dye_" .. part_name},
            })

        end

    end

end
