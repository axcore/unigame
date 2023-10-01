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
lib_ecology:tree_palm_coconut_trunk
{
    tiles = {
        [1] = "lib_ecology_tree_palm_coconut_trunk_top.png",
        [2] = "lib_ecology_tree_palm_coconut_trunk_top.png",
        [3] = "lib_ecology_tree_palm_coconut_trunk.png",
        [4] = "lib_ecology_tree_palm_coconut_trunk.png",
        [5] = "lib_ecology_tree_palm_coconut_trunk.png",
        [6] = "lib_ecology_tree_palm_coconut_trunk.png",
    },
    is_ground_content = false,
    groups = {
        lib_ecology_tree = 1,
        tree = 1,
        choppy = 1,
        flammable = 2,
    },
    sounds = {
    },
    walkable = true,
    after_destruct = "function: 0x402497b0",
    on_place = "function: 0x404ed6d8",
    paramtype2 = "facedir",
    paramtype = "light",
    legacy_wallmounted = false,
    description = "Coconut Palm Trunk",
}

lib_ecology:tree_palm_coconut_wood
{
    tiles = {
        [1] = "lib_ecology_tree_palm_coconut_wood.png",
        [2] = "lib_ecology_tree_palm_coconut_wood.png",
    },
    place_param2 = 0,
    sounds = {
    },
    is_ground_content = false,
    groups = {
        wood = 1,
        oddly_breakable_by_hand = 2,
        choppy = 2,
        flammable = 2,
    },
    paramtype2 = "facedir",
    legacy_wallmounted = false,
    description = "Coconut Palm Wood",
}

lib_ecology:tree_palm_coconut_leaves
{
    tiles = {
        [1] = "lib_ecology_tree_palm_coconut_leaves.png",
        [2] = "lib_ecology_tree_palm_coconut_leaves.png",
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
    on_timer = "function: 0x413650b8",
    sounds = {
    },
    walkable = false,
    after_place_node = "function: 0x41365098",
    waving = 1,
    paramtype2 = "facedir",
    paramtype = "light",
    legacy_wallmounted = false,
    description = "Coconut Palm Leaves",
}

lib_ecology:tree_palm_coconut_sapling
{
    tiles = {
        [1] = "lib_ecology_tree_palm_coconut_sapling.png",
        [2] = "lib_ecology_tree_palm_coconut_sapling.png",
    },
    on_construct = "function: 0x41665570",
    on_place = "function: 0x40dd9d38",
    groups = {
        dig_immediate = 3,
        lib_ecology_sapling = 1,
        sapling = 1,
        snappy = 2,
        attached_node = 1,
        flammable = 2,
    },
    on_timer = "function: 0x41665590",
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
    description = "Coconut Palm Sapling",
}
]]--
