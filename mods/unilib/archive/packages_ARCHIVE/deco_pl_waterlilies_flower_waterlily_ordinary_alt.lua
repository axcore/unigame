---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plantlife/pl_waterlilies
-- Code:    LGPL v3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
biome_lib.register_on_generate({
		surface = {"default:water_source"},
		max_count = lilies_max_count,
		rarity = lilies_rarity,
		min_elevation = 1,
		max_elevation = 40,
		near_nodes = {"default:dirt_with_grass"},
		near_nodes_size = 4,
		near_nodes_vertical = 1,
		near_nodes_count = 1,
		plantlife_limit = -0.9,
		temp_max = -0.22,
		temp_min = 0.22,
	},
	pl_waterlilies.grow_waterlily
)
]]--
