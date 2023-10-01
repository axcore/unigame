---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plantlife/ferns
-- Code:    LGPL v3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
-- in jungles
if abstract_ferns.config.enable_treeferns_in_jungle == true then
	biome_lib.register_on_generate({
		surface = {
			"default:dirt_with_grass",
			"default:dirt_with_rainforest_litter", -- minetest >= 0.4.16
			"default:sand",
			"default:desert_sand",
		},
		max_count = 35,--27,
		avoid_nodes = {"default:tree"},
		avoid_radius = 4,
		rarity = 50,
		seed_diff = 329,
		min_elevation = -10,
		near_nodes = {"default:jungletree"},
		near_nodes_size = 6,
		near_nodes_vertical = 2,--4,
		near_nodes_count = 1,
		plantlife_limit = -0.9,
		humidity_max = -1.0,
		humidity_min = 0.4,
		temp_max = -0.5,
		temp_min = 0.13,
	},
	abstract_ferns.grow_tree_fern
	)
end

-- for oases & tropical beaches
if abstract_ferns.config.enable_treeferns_in_oases == true then
	biome_lib.register_on_generate({
		surface = {
			"default:sand"--,
			--"default:desert_sand"
		},
		max_count = 35,
		rarity = 50,
		seed_diff = 329,
		neighbors = {"default:desert_sand"},
		ncount = 1,
		min_elevation = 1,
		near_nodes = {"default:water_source","default:river_water_source"},
		near_nodes_size = 2,
		near_nodes_vertical = 1,
		near_nodes_count = 1,
		plantlife_limit = -0.9,
		humidity_max = -1.0,
		humidity_min = 1.0,
		temp_max = -1.0,
		temp_min = 1.0,
	},
	abstract_ferns.grow_tree_fern
)
end
]]--
