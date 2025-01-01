---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    forest
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.liquid_mud_normal = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.forest.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.liquid_mud_normal.init()

    return {
        description = "Normal mud (as a liquid)",
        depends = {"dirt_ordinary", "ice_ordinary", "snow_ordinary"},
    }

end

function unilib.pkg.liquid_mud_normal.exec()

    -- (Creates unilib:bucket_steel_with_mud_ordinary, etc)
    unilib.register_liquid({
        part_name = "mud_normal",
        source_name = "unilib:liquid_mud_normal_source",
        flowing_name = "unilib:liquid_mud_normal_flowing",

        burntime = 0,
        description = S("Normal Mud"),
        force_renew_flag = false,
    })

    unilib.register_node("unilib:liquid_mud_normal_source", "forest:mud_source", mode, {
        -- From forest:mud_source
        description = S("Normal Mud Source"),
        tiles = {
            {
                name = "unilib_liquid_mud_normal_animated.png",
                animation = {
                    type = "vertical_frames",
                    aspect_w = 16,
                    aspect_h = 16,
                    length = 9,
                },
            },
        },
        groups = {freezes = 1, liquid = 3, puts_out_fire = 1, water = 1},
        -- (no sounds)

        buildable_to = true,
        diggable = false,
        drawtype = "liquid",
        drop = "",
        drowning = 1,
        inventory_image = core.inventorycube("unilib_liquid_mud_normal.png"),
        -- N.B. is_ground_content = false not in original code; added to match other liquids
        is_ground_content = false,
        liquid_alternative_flowing = "unilib:liquid_mud_normal_flowing",
        liquid_alternative_source = "unilib:liquid_mud_normal_source",
        liquid_viscosity = 6,
        liquidtype = "source",
        post_effect_color = {r = 100, g = 100, b = 200, a = 64},
        special_tiles = {
            {
                name = "unilib_liquid_mud_normal_animated.png",
                animation = {
                    type = "vertical_frames",
                    aspect_w = 16,
                    aspect_h = 16,
                    length = 9,
                },
                backface_culling = false,
            },
        },
        paramtype = "light",
        pointable = false,
        walkable = false,
    })

    unilib.register_node("unilib:liquid_mud_normal_flowing", "forest:mud_flowing", mode, {
        -- From forest:mud_flowing
        description = S("Flowing Normal Mud"),
        tiles = {"unilib_liquid_mud_normal.png"},
        groups = {
            freezes = 1, liquid = 3, melt_around = 1, not_in_creative_inventory = 1,
            puts_out_fire = 1, water = 1,
        },
        -- (no sounds)

        buildable_to = true,
        diggable = false,
        drawtype = "flowingliquid",
        drop = "",
        drowning = 1,
        inventory_image = core.inventorycube("unilib_liquid_mud_normal.png"),
        -- N.B. is_ground_content = false not in original code; added to match other liquids
        is_ground_content = false,
        liquid_alternative_flowing = "unilib:liquid_mud_normal_flowing",
        liquid_alternative_source = "unilib:liquid_mud_normal_source",
        liquid_viscosity = 6,
        liquidtype = "flowing",
        paramtype = "light",
        paramtype2 = "flowingliquid",
        pointable = false,
        post_effect_color = {r = 112, g = 64, b = 32, a = 224},
        special_tiles = {
            {
                image = "unilib_liquid_mud_normal_animated.png",
                animation = {
                    type = "vertical_frames",
                    aspect_w = 16,
                    aspect_h = 16,
                    length = 4,
                },
                backface_culling = false,
            },
            {
                image = "unilib_liquid_mud_normal_animated.png",
                animation = {
                    type = "vertical_frames",
                    aspect_w = 16,
                    aspect_h = 16,
                    length = 4,
                },
                backface_culling = true,
            },
        },
        walkable = false,
    })

end

function unilib.pkg.liquid_mud_normal.post()

    for bucket_type, _ in pairs(unilib.global.generic_bucket_table) do

        local c_water_bucket = "unilib:" .. bucket_type .. "_with_water_ordinary"
        local c_mud_bucket = "unilib:" .. bucket_type .. "_with_mud_normal"

        unilib.register_craft({
            -- From forest/mud.lua
            type = "shapeless",
            output = c_mud_bucket,
            recipe = {c_water_bucket, "unilib:dirt_ordinary"},
        })

    end

end
