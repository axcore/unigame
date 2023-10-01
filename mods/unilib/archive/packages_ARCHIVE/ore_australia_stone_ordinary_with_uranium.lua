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
if minetest.get_modpath("technic_worldgen") then
	minetest.register_ore({
		ore_type        = "scatter",
		ore             = "technic:mineral_uranium",
		wherein         = "default:stone",
		clust_scarcity  = 24 * 24 * 24,
		clust_num_ores  = 4,
		clust_size      = 3,
		biomes          = {"arnhem_land"},
		y_min           = -64,
		y_max           = 35,
		noise_params    = {
			offset = 0,
			scale = 1,
			spread = {x = 100, y = 100, z = 100},
			seed = 420,
			octaves = 3,
			persist = 0.7
			},
		noise_threshold = 0.6,
	})
end
]]--
