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
lib_ecology:bush_rhodedendron_leaves_1
{
    tiles = {
        [1] = "lib_ecology_bush_rhodedendron_leaves_1.png",
        [2] = "lib_ecology_bush_rhodedendron_leaves_1.png",
    },
    visual_scale = 1.5,
    after_place_node = "function: 0x40facc48",
    is_ground_content = false,
    groups = {
        leaves = 1,
        leafdecay = 3,
        snappy = 3,
        flammable = 2,
    },
    on_timer = "function: 0x40545168",
    drawtype = "allfaces_optional",
    on_construct = "function: 0x408319d0",
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
    description = "Bush - Rhodedendron Leaves 1",
}

lib_ecology:bush_rhodedendron_leaves_2
{
    tiles = {
        [1] = "lib_ecology_bush_rhodedendron_leaves_2.png",
        [2] = "lib_ecology_bush_rhodedendron_leaves_2.png",
    },
    visual_scale = 1.5,
    after_place_node = "function: 0x40f9b6a8",
    is_ground_content = false,
    groups = {
        leaves = 1,
        leafdecay = 3,
        snappy = 3,
        flammable = 2,
    },
    on_timer = "function: 0x40530998",
    drawtype = "allfaces_optional",
    on_construct = "function: 0x40fab2b0",
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
    description = "Bush - Rhodedendron Leaves 2",
}

lib_ecology:bush_rhodedendron_leaves_3
{
    tiles = {
        [1] = "lib_ecology_bush_rhodedendron_leaves_3.png",
        [2] = "lib_ecology_bush_rhodedendron_leaves_3.png",
    },
    visual_scale = 1.5,
    is_ground_content = false,
    groups = {
        leaves = 1,
        leafdecay = 3,
        snappy = 3,
        flammable = 2,
    },
    on_timer = "function: 0x4052c548",
    drawtype = "allfaces_optional",
    after_place_node = "function: 0x40e0e490",
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
    description = "Bush - Rhodedendron Leaves 3",
}
]]--
