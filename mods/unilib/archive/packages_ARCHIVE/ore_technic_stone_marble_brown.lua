---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    technic/technic_worldgen
-- Code:    LGPL 2.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
if technic.config:get_bool("enable_marble_generation") then
	minetest.register_ore({
		ore_type = "sheet",
		ore = "technic:marble",
		wherein = "default:stone",
		clust_scarcity = 1,
		clust_num_ores = 1,
		clust_size = 3,
		y_min = -31000,
		y_max = -50,
		noise_threshold = 0.4,
		noise_params = {
			offset = 0, scale = 15, spread = {x = 150, y = 150, z = 150},
			seed = 23, octaves = 3, persist = 0.70
		}
	})
end
]]--
