---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_ore({
		ore_type        = "puff",
		ore             = "aotearoa:mud_with_cockles",
		wherein         = {"aotearoa:mud"},
		clust_scarcity  = 16 * 16 * 16,
		clust_size      = 3,
		y_min           = -7,
		y_max           = 0,
		noise_threshold = 0.19,
		noise_params    = {
			offset = 0,
			scale = 0.8,
			spread = {x = 32, y = 32, z = 32},
			seed = 4607,
			octaves = 2,
			persist = 0.4
		},
		biomes = {
      "northern_estuary",
      "southern_estuary",
    },
})
]]--
