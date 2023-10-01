---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
if minetest.registered_nodes["default:permafrost"] then

	minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:dirt_with_grass"},
		place_offset_y = -1,
		sidelen = 16,
		fill_ratio = 0.01,
		biomes = {"swamp"},
		y_max = 2,
		y_min = 1,
		flags = "force_placement",
		decoration = "default:water_source",
		spawn_by = "default:dirt_with_grass",
		num_spawn_by = 8
	})

	minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:dirt_with_grass"},
		place_offset_y = -1,
		sidelen = 16,
		fill_ratio = 0.1,
		biomes = {"swamp"},
		y_max = 2,
		y_min = 1,
		flags = "force_placement",
		decoration = "default:water_source",
		spawn_by = {"default:dirt_with_grass", "default:water_source"},
		num_spawn_by = 8
	})
end
]]--
