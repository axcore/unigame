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
    ore            = "default:stone_with_gold",
    wherein        = "default:stone",
    clust_scarcity = 13 * 13 * 13,
    clust_num_ores = 5,
    clust_size     = 3,
    y_max          = 31000,
    y_min          = 1025,
})

minetest.register_ore({
    ore_type       = "scatter",
    ore            = "default:stone_with_gold",
    wherein        = "default:stone",
    clust_scarcity = 15 * 15 * 15,
    clust_num_ores = 3,
    clust_size     = 2,
    y_max          = -256,
    y_min          = -511,
})

minetest.register_ore({
    ore_type       = "scatter",
    ore            = "default:stone_with_gold",
    wherein        = "default:stone",
    clust_scarcity = 13 * 13 * 13,
    clust_num_ores = 5,
    clust_size     = 3,
    y_max          = -512,
    y_min          = -31000,
})
]]--
