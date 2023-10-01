---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr11
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
lib_materials:liquid_water_swamp_source
{
    is_ground_content = true,
    buildable_to = true,
    drowning = 1,
    drawtype = "liquid",
    sounds = {
        dug = {
            name = "default_dug_node",
            gain = 0.25,
        },
        footstep = {
            name = "default_water_footstep",
            gain = 0.2,
        },
        place = {
            name = "default_place_node_hard",
            gain = 1,
        },
    },
    liquid_alternative_flowing = "lib_materials:fluid_water_swamp_flowing",
    alpha = 160,
    liquid_range = 3,
    paramtype = "light",
    description = "Swamp Water Source",
    tiles = {
        [1] = {
            backface_culling = false,
            name = "lib_materials_fluid_water_swamp_source_animated.png",
            animation = {
                type = "vertical_frames",
                length = 1.5,
                aspect_h = 16,
                aspect_w = 16,
            },
        },
        [2] = {
            backface_culling = true,
            name = "lib_materials_fluid_water_swamp_source_animated.png",
            animation = {
                type = "vertical_frames",
                length = 1.5,
                aspect_h = 16,
                aspect_w = 16,
            },
        },
    },
    liquidtype = "source",
    pointable = false,
    liquid_alternative_source = "lib_materials:fluid_water_swamp_source",
    liquid_viscosity = 1,
    liquid_renewable = false,
    diggable = false,
    walkable = false,
    groups = {
        liquid = 2,
        cools_lava = 1,
        water = 3,
        puts_out_fire = 1,
    },
}

lib_materials:liquid_water_swamp_flowing
{
    is_ground_content = true,
    buildable_to = true,
    drowning = 1,
    drawtype = "flowingliquid",
    sounds = {
        dug = {
            name = "default_dug_node",
            gain = 0.25,
        },
        footstep = {
            name = "default_water_footstep",
            gain = 0.2,
        },
        place = {
            name = "default_place_node_hard",
            gain = 1,
        },
    },
    liquid_alternative_flowing = "lib_materials:fluid_water_swamp_flowing",
    alpha = 160,
    liquid_range = 3,
    paramtype = "light",
    description = "Swamp Water Flowing",
    tiles = {
        [1] = "lib_materials_fluid_water_swamp_source.png",
    },
    special_tiles = {
        [1] = {
            backface_culling = false,
            name = "lib_materials_fluid_water_swamp_flowing_animated.png",
            animation = {
                type = "vertical_frames",
                length = 1.5,
                aspect_h = 16,
                aspect_w = 16,
            },
        },
        [2] = {
            backface_culling = true,
            name = "lib_materials_fluid_water_swamp_flowing_animated.png",
            animation = {
                type = "vertical_frames",
                length = 1.5,
                aspect_h = 16,
                aspect_w = 16,
            },
        },
    },
    liquidtype = "flowing",
    diggable = false,
    walkable = false,
    liquid_viscosity = 1,
    liquid_renewable = false,
    paramtype2 = "flowingliquid",
    liquid_alternative_source = "lib_materials:fluid_water_swamp_source",
    pointable = false,
    groups = {
        not_in_creative_inventory = 1,
        liquid = 2,
        puts_out_fire = 1,
        cools_lava = 1,
        water = 3,
    },
}
]]--
