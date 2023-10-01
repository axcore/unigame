---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    steampunk
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.liquid_grease_normal = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.steampunk.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.liquid_grease_normal.init()

    return {
        description = "Normal grease",
        depends = "mineral_coal",
    }

end

function unilib.pkg.liquid_grease_normal.exec()

    -- (Creates unilib:bucket_steel_with_grease_normal, etc)
    unilib.register_liquid({
        part_name = "grease_normal",
        source_name = "unilib:liquid_grease_normal_source",
        flowing_name = "unilib:liquid_grease_normal_flowing",

        burntime = 0,
        description = S("Normal Grease"),
        force_renew_flag = false,
    })

    unilib.register_node("unilib:liquid_grease_normal_source", "steampunk:grease_source", mode, {
        -- From steampunk:grease_source
        description = S("Normal Grease Source"),
        tiles = {
            {
                name = "unilib_liquid_grease_normal_source_animated.png",
                animation = {
                    type = "vertical_frames",
                    aspect_w = 16,
                    aspect_h = 16,
                    length = 2.0,
                },
            },
        },
        groups = {cools_lava = 1, liquid = 3, puts_out_fire = 1, water = 3},
        sounds = unilib.sound_table.water,

        buildable_to = true,
        diggable = false,
        drawtype = "liquid",
        drop = "",
        drowning = 1,
        is_ground_content = false,
        liquidtype = "source",
        liquid_alternative_flowing = "unilib:liquid_grease_normal_flowing",
        liquid_alternative_source = "unilib:liquid_grease_normal_source",
        liquid_viscosity = 1,
        paramtype = "light",
        pointable = false,
        post_effect_color = {r = 107, g = 53, b = 18, a = 103},
        special_tiles = {
            {
                name = "unilib_liquid_grease_normal_source_animated.png",
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
    })

    unilib.register_node("unilib:liquid_grease_normal_flowing", "steampunk:grease_flowing", mode, {
        -- From steampunk:grease_flowing
        description = S("Flowing Normal Grease"),
        tiles = {"unilib_liquid_grease_normal.png"},
        groups = {
            cools_lava = 1, liquid = 3, not_in_creative_inventory = 1, puts_out_fire = 1, water = 3,
        },
        sounds = unilib.sound_table.water,

        buildable_to = true,
        diggable = false,
        drawtype = "flowingliquid",
        drop = "",
        drowning = 1,
        is_ground_content = false,
        liquidtype = "flowing",
        liquid_alternative_flowing = "unilib:liquid_grease_normal_flowing",
        liquid_alternative_source = "unilib:liquid_grease_normal_source",
        liquid_viscosity = 1,
        pointable = false,
        special_tiles = {
            {
                name = "unilib_liquid_grease_normal_flowing_animated.png",
                backface_culling = false,
                animation = {
                    type = "vertical_frames",
                    aspect_w = 16,
                    aspect_h = 16,
                    length = 0.8,
                },
            },
            {
                name = "unilib_liquid_grease_normal_flowing_animated.png",
                backface_culling = true,
                animation = {
                    type = "vertical_frames",
                    aspect_w = 16,
                    aspect_h = 16,
                    length = 0.8,
                },
            },
        },
        paramtype = "light",
        paramtype2 = "flowingliquid",
        post_effect_color = {r = 45, g = 23, b = 7, a = 103},
        use_texture_alpha = "blend",
        walkable = false,
    })

end

function unilib.pkg.liquid_grease_normal.post()

    local c_coal = "unilib:mineral_coal_lump"

    unilib.register_craft({
        -- From steampunk:grease_source
        output = "unilib:liquid_grease_normal_source",
        recipe = {
            {c_coal, c_coal, c_coal},
            {c_coal, "group:craftable_bucket", c_coal},
            {c_coal, c_coal, c_coal},
        },
        replacements = unilib.craftable_bucket_list,
    })

end
