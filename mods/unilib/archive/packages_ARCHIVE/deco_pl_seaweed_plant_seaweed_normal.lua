---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plantlife/pl_seaweed
-- Code:    LGPL v3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
biome_lib.register_on_generate({
		surface = {"default:water_source"},
		max_count = seaweed_max_count,
		rarity = seaweed_rarity,
		min_elevation = 1,
		max_elevation = 40,
		near_nodes = {"default:dirt_with_grass"},
		near_nodes_size = 4,
		near_nodes_vertical = 1,
		near_nodes_count = 1,
		plantlife_limit = -0.9,
	},
	pl_seaweed.grow_seaweed
)

-- pl_seaweed at beaches
-- MM: not satisfied with it, but IMHO some beaches should have some algae
biome_lib.register_on_generate({
		surface = {"default:water_source"},
		max_count = seaweed_max_count,
		rarity = seaweed_rarity,
		min_elevation = 1,
		max_elevation = 40,
		near_nodes = {"default:sand"},
		near_nodes_size = 1,
		near_nodes_vertical = 0,
		near_nodes_count = 3,
		plantlife_limit = -0.9,
		temp_max = -0.64, -- MM: more or less random values, just to make sure it's not everywhere
		temp_min = -0.22, -- MM: more or less random values, just to make sure it's not everywhere
	},
	pl_seaweed.grow_seaweed
)

biome_lib.register_on_generate({
		surface = {"default:sand"},
		max_count = seaweed_max_count*2,
		rarity = seaweed_rarity/2,
		min_elevation = 1,
		max_elevation = 40,
		near_nodes = {"default:water_source"},
		near_nodes_size = 1,
		near_nodes_vertical = 0,
		near_nodes_count = 3,
		plantlife_limit = -0.9,
		temp_max = -0.64, -- MM: more or less random values, just to make sure it's not everywhere
		temp_min = -0.22, -- MM: more or less random values, just to make sure it's not everywhere
	},
	pl_seaweed.grow_seaweed
)
]]--
