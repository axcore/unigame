---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plantlife/youngtrees
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
biome_lib.register_on_generate({
		surface = {
			"default:dirt_with_grass",
			"stoneage:grass_with_silex",
			"sumpf:peat",
			"sumpf:sumpf"
		},
		rarity = youngtrees_youngtrees_rarity,
		rarity_fertility = youngtrees_youngtrees_rarity_fertility,
		plantlife_limit = youngtrees_youngtrees_fertility,
		min_elevation = 1, -- above sea level
	},
	abstract_youngtrees.grow_youngtree
)
]]--
