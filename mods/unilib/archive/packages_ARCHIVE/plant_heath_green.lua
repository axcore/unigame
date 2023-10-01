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
lib_ecology:plant_heath_green
{
    tiles = {
        [1] = "lib_ecology_plant_heath_green.png",
        [2] = "lib_ecology_plant_heath_green.png",
    },
    selection_box = {
        type = "fixed",
        fixed = {
            [1] = {
                [1] = "-0.3",
                [2] = "-0.5",
                [3] = "-0.3",
                [4] = "0.3",
                [5] = "0",
                [6] = "0.3",
            },
        },
    },
    is_ground_content = false,
    groups = {
        leaves = 1,
        flora = 1,
        lib_ecology_plant = 1,
        attached_node = 1,
        snappy = 3,
        oddly_breakable_by_hand = 1,
        flammable = 1,
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
    description = "Plant - Heath Green",
}
]]--
