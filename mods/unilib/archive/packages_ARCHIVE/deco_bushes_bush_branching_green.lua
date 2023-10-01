---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plantlife/bushes
-- Code:    LGPL v3.0
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
		rarity = bushes_bush_rarity,
		rarity_fertility = bushes_bush_rarity_fertility,
		plantlife_limit = bushes_bush_fertility,
		min_elevation = 1, -- above sea level
	},
	abstract_bushes.grow_bush
)
]]--
