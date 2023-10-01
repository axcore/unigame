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
lib_ecology:flower_dandelions_white
{
    tiles = {
        [1] = "lib_ecology_flower_dandelions_white.png",
        [2] = "lib_ecology_flower_dandelions_white.png",
    },
    visual_scale = 1,
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
    sunlight_propagates = true,
    drawtype = "plantlike",
    waving = 1,
    sounds = {
    },
    walkable = false,
    floodable = true,
    buildable_to = false,
    legacy_wallmounted = false,
    wield_scale = {
        y = 0.5,
        x = 0.5,
        z = 0.5,
    },
    paramtype = "light",
    description = "Flower - dandelions Yellow",
}
]]--
