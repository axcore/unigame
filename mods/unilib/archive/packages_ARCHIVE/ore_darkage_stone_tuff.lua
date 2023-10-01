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
	ore             	= "darkage:tuff",
	wherein         	= {"default:stone", "default:needs_dirt", "default:gravel", "default:stone_with_coal"},
	column_height_max = 20,
	column_height_min = 15,
	y_min            = -200,
	y_max            = 200,
	noise_threshold = 0.5,
	noise_params     = {
		offset = 0.35,
		scale = 0.19,
		seed = seed+12,
		spread = {x = 45, y = 45, z = 45},
		octaves = 1,
		persistence = 0.6
	},
})
]]--
