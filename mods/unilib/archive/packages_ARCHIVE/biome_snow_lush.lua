---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    snow
-- Code:    GPL 3.0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_biome({
	name           = "snow_biome_lush",

	node_top       = "default:dirt_with_snow",
	depth_top      = 1,
	node_filler    = "default:dirt",
	depth_filler   = 2,

	height_min     = snow.min_height,
	height_max     = snow.min_height+60,
	heat_point     = 10.0,
	humidity_point = 70.0,
})
]]--
