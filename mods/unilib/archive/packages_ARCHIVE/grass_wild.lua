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
lib_ecology:grass_green_1
{
    tiles = {
        [1] = "lib_ecology_grass_green_1.png",
        [2] = "lib_ecology_grass_green_1.png",
    },
    on_construct = "function: 0x40b2d830",
    selection_box = {
        type = "fixed",
        fixed = {
            [1] = {
                [1] = "-0.375",
                [2] = "-0.5",
                [3] = "-0.375",
                [4] = "0.375",
                [5] = "-0.3125",
                [6] = "0.375",
            },
        },
    },
    is_ground_content = false,
    groups = {
        flammable = 1,
        flora = 1,
        growing = 1,
        grass = 1,
        snappy = 3,
        attached_node = 1,
        plant = 1,
    },
    on_timer = "function: 0x40b2d850",
    drawtype = "plantlike",
    sunlight_propagates = true,
    sounds = {
    },
    walkable = false,
    waving = 1,
    floodable = true,
    buildable_to = false,
    paramtype = "light",
    legacy_wallmounted = false,
    description = "Grass - Green 1",
}

lib_ecology:grass_green_2
{
    tiles = {
        [1] = "lib_ecology_grass_green_2.png",
        [2] = "lib_ecology_grass_green_2.png",
    },
    on_construct = "function: 0x407ecc50",
    selection_box = {
        type = "fixed",
        fixed = {
            [1] = {
                [1] = "-0.375",
                [2] = "-0.5",
                [3] = "-0.375",
                [4] = "0.375",
                [5] = "-0.3125",
                [6] = "0.375",
            },
        },
    },
    is_ground_content = false,
    groups = {
        not_in_creative_inventory = 1,
        flammable = 1,
        flora = 1,
        growing = 1,
        grass = 1,
        snappy = 3,
        attached_node = 1,
        plant = 1,
    },
    on_timer = "function: 0x407ecc70",
    drawtype = "plantlike",
    sunlight_propagates = true,
    sounds = {
    },
    walkable = false,
    waving = 1,
    floodable = true,
    buildable_to = false,
    paramtype = "light",
    legacy_wallmounted = false,
    description = "Grass - Green 2",
}

lib_ecology:grass_green_3
{
    tiles = {
        [1] = "lib_ecology_grass_green_3.png",
        [2] = "lib_ecology_grass_green_3.png",
    },
    on_construct = "function: 0x407f6e08",
    selection_box = {
        type = "fixed",
        fixed = {
            [1] = {
                [1] = "-0.375",
                [2] = "-0.5",
                [3] = "-0.375",
                [4] = "0.375",
                [5] = "-0.3125",
                [6] = "0.375",
            },
        },
    },
    is_ground_content = false,
    groups = {
        not_in_creative_inventory = 1,
        flammable = 1,
        flora = 1,
        growing = 1,
        grass = 1,
        snappy = 3,
        attached_node = 1,
        plant = 1,
    },
    on_timer = "function: 0x407f6e28",
    drawtype = "plantlike",
    sunlight_propagates = true,
    sounds = {
    },
    walkable = false,
    waving = 1,
    floodable = true,
    buildable_to = false,
    paramtype = "light",
    legacy_wallmounted = false,
    description = "Grass - Green 3",
}

lib_ecology:grass_green_4
{
    tiles = {
        [1] = "lib_ecology_grass_green_4.png",
        [2] = "lib_ecology_grass_green_4.png",
    },
    on_construct = "function: 0x407f7050",
    selection_box = {
        type = "fixed",
        fixed = {
            [1] = {
                [1] = "-0.375",
                [2] = "-0.5",
                [3] = "-0.375",
                [4] = "0.375",
                [5] = "-0.3125",
                [6] = "0.375",
            },
        },
    },
    is_ground_content = false,
    groups = {
        not_in_creative_inventory = 1,
        flammable = 1,
        flora = 1,
        growing = 1,
        grass = 1,
        snappy = 3,
        attached_node = 1,
        plant = 1,
    },
    on_timer = "function: 0x407f7070",
    drawtype = "plantlike",
    sunlight_propagates = true,
    sounds = {
    },
    walkable = false,
    waving = 1,
    floodable = true,
    buildable_to = false,
    paramtype = "light",
    legacy_wallmounted = false,
    description = "Grass - Green 4",
}

lib_ecology:grass_green_5
{
    tiles = {
        [1] = "lib_ecology_grass_green_5.png",
        [2] = "lib_ecology_grass_green_5.png",
    },
    selection_box = {
        type = "fixed",
        fixed = {
            [1] = {
                [1] = "-0.375",
                [2] = "-0.5",
                [3] = "-0.375",
                [4] = "0.375",
                [5] = "-0.3125",
                [6] = "0.375",
            },
        },
    },
    is_ground_content = false,
    groups = {
        not_in_creative_inventory = 1,
        flammable = 1,
        flora = 1,
        growing = 0,
        grass = 1,
        snappy = 3,
        attached_node = 1,
        plant = 1,
    },
    drawtype = "plantlike",
    sunlight_propagates = true,
    sounds = {
    },
    walkable = false,
    waving = 1,
    floodable = true,
    buildable_to = false,
    paramtype = "light",
    legacy_wallmounted = false,
    description = "Grass - Green 5",
}
]]--
