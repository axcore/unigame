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
	ore             	= "darkage:chalk",
	wherein         	= {"default:stone"},
	column_height_max = 30,
	column_height_min = 20,
	y_min            = -20,
	y_max            = 50,
	noise_threshold = 0.45,
	noise_params     = {
		offset = 0.35,
		scale = 0.2,
		spread = {x = 30, y = 30, z = 30},
		octaves = 1,
		persistence = 0.6
	},
})
]]--
