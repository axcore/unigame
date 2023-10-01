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
lib_materials:liquid_metal_copper_source
{
    light_source = 8,
    groups = {
        metal = 1,
        liquid = 3,
        igniter = 1,
    },
    drawtype = "liquid",
    sounds = {
    },
    liquid_alternative_flowing = "lib_materials:fluid_copper_flowing",
    damage_per_second = 6,
    paramtype = "light",
    description = "Copper Source",
    tiles = {
        [1] = {
            backface_culling = false,
            name = "lib_materials_fluid_copper_source_animated.png",
            animation = {
                type = "vertical_frames",
                length = 3,
                aspect_h = 16,
                aspect_w = 16,
            },
        },
        [2] = {
            backface_culling = true,
            name = "lib_materials_fluid_copper_source_animated.png",
            animation = {
                type = "vertical_frames",
                length = 3,
                aspect_h = 16,
                aspect_w = 16,
            },
        },
    },
    liquid_renewable = false,
    diggable = false,
    liquid_alternative_source = "lib_materials:fluid_copper_source",
    liquid_viscosity = 1,
    pointable = false,
    walkable = false,
    buildable_to = true,
    liquidtype = "source",
}

lib_materials:liquid_metal_copper_flowing
{
    light_source = 8,
    buildable_to = true,
    drawtype = "flowingliquid",
    sounds = {
    },
    liquid_alternative_flowing = "lib_materials:fluid_copper_flowing",
    damage_per_second = 6,
    paramtype = "light",
    description = "Copper Flowing",
    tiles = {
        [1] = "lib_materials_fluid_copper_source.png",
    },
    special_tiles = {
        [1] = {
            backface_culling = false,
            name = "lib_materials_fluid_copper_flowing_animated.png",
            animation = {
                type = "vertical_frames",
                length = 3.3,
                aspect_h = 16,
                aspect_w = 16,
            },
        },
        [2] = {
            backface_culling = true,
            name = "lib_materials_fluid_copper_flowing_animated.png",
            animation = {
                type = "vertical_frames",
                length = 3.3,
                aspect_h = 16,
                aspect_w = 16,
            },
        },
    },
    liquidtype = "flowing",
    diggable = false,
    liquid_alternative_source = "lib_materials:fluid_copper_source",
    liquid_viscosity = 1,
    liquid_renewable = false,
    paramtype2 = "flowingliquid",
    pointable = false,
    walkable = false,
    groups = {
        metal = 1,
        not_in_creative_inventory = 1,
        liquid = 3,
        igniter = 1,
    },
}
]]--
