---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_ore({
	ore_type        = "blob",
	ore             = "default:stone_with_copper",
	wherein         = {"default:stone"},
	clust_scarcity  = 48 * 48 * 48,
	clust_size      = 8,
	biomes          = {"flinders_lofty"},
	y_min           = -64,
	y_max           = 64,
	noise_threshold = 1,
	noise_params    = {
		offset = 0,
		scale = 3,
		spread = {x = 16, y = 16, z = 16},
		seed = 892,
		octaves = 3,
		persist = 0.6
	},
})

minetest.register_ore({
	ore_type        = "blob",
	ore             = "default:stone_with_copper",
	wherein         = {"default:stone"},
	clust_scarcity  = 44 * 44 * 44,
	clust_size      = 8,
	biomes          = {"gulf_of_carpentaria"},
	y_min           = -64,
	y_max           = 0,
	noise_threshold = 1,
	noise_params    = {
		offset = 0,
		scale = 3,
		spread = {x = 16, y = 16, z = 16},
		seed = 890,
		octaves = 3,
		persist = 0.6
	},
})
]]--
