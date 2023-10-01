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
lib_materials:liquid_lava_cooling_source
{
    light_source = 8,
    is_ground_content = true,
    groups = {
        igniter = 1,
        liquid = 1,
        lava = 3,
        crumbly = 3,
    },
    drawtype = "liquid",
    sounds = {
    },
    liquid_alternative_flowing = "lib_materials:lava_cooling_flowing",
    damage_per_second = 6,
    liquid_range = 3,
    paramtype = "light",
    description = "Cooling Lava Source",
    tiles = {
        [1] = {
            backface_culling = false,
            name = "lib_materials_stone_cobble_default.png^(lib_materials_fluid_lava_source_animated.png^[mask:lib_materials_mask_cobble.png)",
            animation = {
                type = "vertical_frames",
                length = 3,
                aspect_h = 16,
                aspect_w = 16,
            },
        },
        [2] = {
            backface_culling = true,
            name = "lib_materials_stone_cobble_default.png^(lib_materials_fluid_lava_source_animated.png^[mask:lib_materials_mask_cobble.png)",
            animation = {
                type = "vertical_frames",
                length = 3,
                aspect_h = 16,
                aspect_w = 16,
            },
        },
    },
    liquidtype = "source",
    diggable = false,
    liquid_alternative_source = "lib_materials:lava_cooling_source",
    liquid_viscosity = 7,
    liquid_renewable = false,
    pointable = false,
    walkable = false,
    buildable_to = true,
}

lib_materials:liquid_lava_cooling_flowing
{
    light_source = 8,
    is_ground_content = true,
    buildable_to = true,
    drawtype = "flowingliquid",
    sounds = {
    },
    liquid_alternative_flowing = "lib_materials:lava_cooling_flowing",
    damage_per_second = 6,
    liquid_range = 3,
    paramtype = "light",
    description = "Cooling Lava Flowing",
    tiles = {
        [1] = "lib_materials_stone_cobble_default.png^(lib_materials_fluid_lava_source.png^[mask:lib_materials_mask_cobble.png)",
    },
    special_tiles = {
        [1] = {
            backface_culling = false,
            name = "lib_materials_stone_cobble_default.png^(lib_materials_fluid_lava_flowing_animated.png^[mask:lib_materials_mask_cobble.png)",
            animation = {
                type = "vertical_frames",
                length = 3.3,
                aspect_h = 16,
                aspect_w = 16,
            },
        },
        [2] = {
            backface_culling = true,
            name = "lib_materials_stone_cobble_default.png^(lib_materials_fluid_lava_flowing_animated.png^[mask:lib_materials_mask_cobble.png)",
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
    walkable = false,
    liquid_viscosity = 7,
    liquid_renewable = false,
    paramtype2 = "flowingliquid",
    liquid_alternative_source = "lib_materials:lava_cooling_source",
    pointable = false,
    groups = {
        igniter = 1,
        liquid = 1,
        not_in_creative_inventory = 1,
        lava = 3,
        crumbly = 3,
    },
}
]]--
