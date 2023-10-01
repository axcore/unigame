---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plantlife/molehills
-- Code:    LGPL v3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
biome_lib.register_on_generate({
		surface = {"default:dirt_with_grass"},
		rarity = molehills_rarity,
		rarity_fertility = molehills_rarity_fertility,
		plantlife_limit = molehills_fertility,
		min_elevation = 1,
		max_elevation = 40,
		avoid_nodes = {"group:tree","group:liquid","group:stone","group:falling_node",
		avoid_radius = 4,
	},
	abstract_molehills.place_molehill
)
]]--
