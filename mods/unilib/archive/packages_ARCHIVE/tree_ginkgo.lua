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
lib_ecology:tree_ginkgo_trunk
{
    tiles = {
        [1] = "lib_ecology_tree_ginkgo_trunk_top.png",
        [2] = "lib_ecology_tree_ginkgo_trunk_top.png",
        [3] = "lib_ecology_tree_ginkgo_trunk.png",
        [4] = "lib_ecology_tree_ginkgo_trunk.png",
        [5] = "lib_ecology_tree_ginkgo_trunk.png",
        [6] = "lib_ecology_tree_ginkgo_trunk.png",
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
    after_destruct = "function: 0x41a7bf28",
    on_place = "function: 0x404ed6d8",
    paramtype2 = "facedir",
    paramtype = "light",
    legacy_wallmounted = false,
    description = "Ginkgo Trunk",
}

lib_ecology:tree_ginkgo_wood
{
    tiles = {
        [1] = "lib_ecology_tree_ginkgo_wood.png",
        [2] = "lib_ecology_tree_ginkgo_wood.png",
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
    description = "Ginkgo Wood",
}

lib_ecology:tree_ginkgo_leaves
{
    tiles = {
        [1] = "lib_ecology_tree_ginkgo_leaves.png",
        [2] = "lib_ecology_tree_ginkgo_leaves.png",
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
    on_timer = "function: 0x41de4e90",
    sounds = {
    },
    walkable = false,
    after_place_node = "function: 0x41241830",
    waving = 1,
    paramtype2 = "facedir",
    paramtype = "light",
    legacy_wallmounted = false,
    description = "Ginkgo Leaves",
}

lib_ecology:tree_ginkgo_sapling
{
    tiles = {
        [1] = "lib_ecology_tree_ginkgo_sapling.png",
        [2] = "lib_ecology_tree_ginkgo_sapling.png",
    },
    on_construct = "function: 0x41c173b8",
    on_place = "function: 0x41fb16d0",
    groups = {
        dig_immediate = 3,
        lib_ecology_sapling = 1,
        sapling = 1,
        snappy = 2,
        attached_node = 1,
        flammable = 2,
    },
    on_timer = "function: 0x41bf2638",
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
    description = "Ginkgo Sapling",
}
]]--
