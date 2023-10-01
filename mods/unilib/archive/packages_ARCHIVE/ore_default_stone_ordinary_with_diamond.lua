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
    ore            = "default:stone_with_diamond",
    wherein        = "default:stone",
    clust_scarcity = 15 * 15 * 15,
    clust_num_ores = 4,
    clust_size     = 3,
    y_max          = 31000,
    y_min          = 1025,
})

minetest.register_ore({
    ore_type       = "scatter",
    ore            = "default:stone_with_diamond",
    wherein        = "default:stone",
    clust_scarcity = 17 * 17 * 17,
    clust_num_ores = 4,
    clust_size     = 3,
    y_max          = -1024,
    y_min          = -2047,
})

minetest.register_ore({
    ore_type       = "scatter",
    ore            = "default:stone_with_diamond",
    wherein        = "default:stone",
    clust_scarcity = 15 * 15 * 15,
    clust_num_ores = 4,
    clust_size     = 3,
    y_max          = -2048,
    y_min          = -31000,
})
]]--
