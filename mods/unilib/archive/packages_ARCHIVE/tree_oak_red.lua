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
lib_ecology:tree_oak_red_leaves
{
    tiles = {
        [1] = "lib_ecology_tree_oak_red_leaves.png",
        [2] = "lib_ecology_tree_oak_red_leaves.png",
    },
    is_ground_content = false,
    groups = {
        leaves = 1,
        lib_ecology_leaves = 1,
        leafdecay = 3,
        snappy = 3,
        flammable = 2,
    },
    drawtype = "allfaces_optional",
    on_timer = "function: 0x40d77b60",
    sounds = {
    },
    walkable = false,
    after_place_node = "function: 0x406c20b8",
    waving = 1,
    paramtype2 = "facedir",
    paramtype = "light",
    legacy_wallmounted = false,
    description = "Red Oak Leaves",
}

lib_ecology:tree_oak_red_sapling
{
    tiles = {
        [1] = "lib_ecology_tree_oak_red_sapling.png",
        [2] = "lib_ecology_tree_oak_red_sapling.png",
    },
    on_construct = "function: 0x406b0fe8",
    on_place = "function: 0x40e01f78",
    groups = {
        dig_immediate = 3,
        lib_ecology_sapling = 1,
        sapling = 1,
        snappy = 2,
        attached_node = 1,
        flammable = 2,
    },
    on_timer = "function: 0x41364ce8",
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
    description = "Red Oak Sapling",
}
]]--
