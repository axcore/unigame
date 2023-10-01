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
    ore_type        = "stratum",
    ore             = "default:sandstone",
    wherein         = {"default:desert_stone"},
    clust_scarcity  = 1,
    y_max           = 39,
    y_min           = 3,
    noise_params    = {
        offset = 21,
        scale = 16,
        spread = {x = 128, y = 128, z = 128},
        seed = 90122,
        octaves = 1,
    },
    stratum_thickness = 2,
    biomes = {"desert"},
})
]]--
