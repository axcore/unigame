---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    darkage
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_ore({
	ore_type        	= "sheet",
	ore             	= "darkage:ors",
	wherein         	= {"default:stone", "default:dirt", "default:gravel", "default:stone_with_coal"},
	column_height_max = 8,
	column_height_min = 6,
	y_min            = -200,
	y_max            = 500,
	noise_threshold = 0.49,
	noise_params     = {
		offset = 0.28,
		scale = 0.3,
		seed = seed+4,
		spread = {x = 10, y = 10, z = 10},
		octaves = 1,
		persistence = 0.6
	},
})
]]--
