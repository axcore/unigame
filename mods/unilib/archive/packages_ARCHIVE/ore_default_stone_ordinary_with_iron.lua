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
    ore            = "default:stone_with_iron",
    wherein        = "default:stone",
    clust_scarcity = 9 * 9 * 9,
    clust_num_ores = 12,
    clust_size     = 3,
    y_max          = 31000,
    y_min          = 1025,
})

minetest.register_ore({
    ore_type       = "scatter",
    ore            = "default:stone_with_iron",
    wherein        = "default:stone",
    clust_scarcity = 7 * 7 * 7,
    clust_num_ores = 5,
    clust_size     = 3,
    y_max          = -128,
    y_min          = -255,
})

minetest.register_ore({
    ore_type       = "scatter",
    ore            = "default:stone_with_iron",
    wherein        = "default:stone",
    clust_scarcity = 12 * 12 * 12,
    clust_num_ores = 29,
    clust_size     = 5,
    y_max          = -256,
    y_min          = -31000,
})
]]--
