---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_ore({
    ore_type       = "scatter",
    ore            = "default:stone_with_tin",
    wherein        = "default:stone",
    clust_scarcity = 10 * 10 * 10,
    clust_num_ores = 5,
    clust_size     = 3,
    y_max          = 31000,
    y_min          = 1025,
})

minetest.register_ore({
    ore_type       = "scatter",
    ore            = "default:stone_with_tin",
    wherein        = "default:stone",
    clust_scarcity = 13 * 13 * 13,
    clust_num_ores = 4,
    clust_size     = 3,
    y_max          = -64,
    y_min          = -127,
})

minetest.register_ore({
    ore_type       = "scatter",
    ore            = "default:stone_with_tin",
    wherein        = "default:stone",
    clust_scarcity = 10 * 10 * 10,
    clust_num_ores = 5,
    clust_size     = 3,
    y_max          = -128,
    y_min          = -31000,
})
]]--
