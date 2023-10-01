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
lib_ecology:bush_hawthorne_leaves
{
    tiles = {
        [1] = "lib_ecology_bush_hawthorne_leaves.png",
        [2] = "lib_ecology_bush_hawthorne_leaves.png",
    },
    visual_scale = 2,
    is_ground_content = false,
    groups = {
        leaves = 1,
        leafdecay = 3,
        snappy = 3,
        flammable = 2,
    },
    on_timer = "function: 0x417adec0",
    drawtype = "allfaces_optional",
    after_place_node = "function: 0x4083a860",
    sounds = {
    },
    walkable = false,
    waving = 1,
    floodable = true,
    legacy_wallmounted = false,
    wield_scale = {
        y = 0.5,
        x = 0.5,
        z = 0.5,
    },
    paramtype = "light",
    description = "Bush - Hawthorne Leaves",
}
]]--
