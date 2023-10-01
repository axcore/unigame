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
    ore_type        = "blob",
    ore             = "default:dirt",
    wherein         = {"default:stone"},
    clust_scarcity  = 16 * 16 * 16,
    clust_size      = 5,
    y_max           = 31000,
    y_min           = -31,
    noise_threshold = 0.0,
    noise_params    = {
        offset = 0.5,
        scale = 0.2,
        spread = {x = 5, y = 5, z = 5},
        seed = 17676,
        octaves = 1,
        persist = 0.0
    },
    -- Only where default:dirt is present as surface material
    biomes = {"taiga", "snowy_grassland", "grassland", "coniferous_forest",
            "deciduous_forest", "deciduous_forest_shore", "rainforest",
            "rainforest_swamp"}
})
]]--
