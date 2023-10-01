---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plantlife/cavestuff
-- Code:    LGPL v3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
biome_lib.register_on_generate(
	{
		surface = {
			"default:desert_sand",
			"default:desert_stone"
		},
		max_count = 50,
		rarity = 0,
		plantlife_limit = -1,
		check_air = true,
		random_facedir = {0, 3}
	},
	{
		"cavestuff:desert_pebble_1",
		"cavestuff:desert_pebble_2"
	}
)
]]--
