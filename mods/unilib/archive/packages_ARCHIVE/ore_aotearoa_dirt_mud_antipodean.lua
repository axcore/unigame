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
	ore_type        = "blob",
	ore             = "aotearoa:mud_sinking",
	wherein         = {
		"aotearoa:restiad_peat",
		"aotearoa:forest_peat",
		"aotearoa:gumland_soil",
	 },
	clust_scarcity  = 16 * 16 * 16,
	clust_size      = 3,
	y_min           = -31000,
	y_max           = 31000,
	noise_threshold = 0.0,
	noise_params    = {
		offset = 0.5,
		scale = 0.6,
		spread = {x = 10, y = 10, z = 10},
		seed = 74331,
		octaves = 1,
		persist = 0.3
	},
	--biomes = {},
})
]]--
