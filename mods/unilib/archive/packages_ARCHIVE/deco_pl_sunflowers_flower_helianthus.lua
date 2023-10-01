---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plantlife/pl_sunflowers
-- Code:    LGPL v3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
biome_lib.register_on_generate({
	surface = {"default:dirt_with_grass"},
	avoid_nodes = { "flowers:sunflower" },
	max_count = sunflowers_max_count,
	rarity = sunflowers_rarity,
	min_elevation = 0,
	plantlife_limit = -0.9,
	temp_max = -0.1,
	random_facedir = {0,3},
	},
	"flowers:sunflower"
)
]]--
