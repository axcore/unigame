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
lib_ecology:plant_banana_1
{
    tiles = {
        [1] = "lib_ecology_plant_banana_1.png",
        [2] = "lib_ecology_plant_banana_1.png",
    },
    on_construct = "function: 0x419d2b40",
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
        growing = 1,
        flammable = 2,
        snappy = 3,
        attached_node = 1,
        plant = 1,
    },
    on_timer = "function: 0x419cccb0",
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
    description = "Plant - Banana 1",
}
]]--
