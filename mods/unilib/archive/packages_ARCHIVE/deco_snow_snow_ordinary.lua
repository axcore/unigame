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
--Snow.
minetest.register_decoration({
	deco_type = "simple",
	place_on = "default:dirt_with_snow",
	sidelen = 16,
	fill_ratio = 10,
	biomes = {"snow_biome_default", "snow_biome_forest", "snow_biome_lush"},
	decoration = "default:snow",
})

minetest.register_decoration({
	deco_type = "simple",
	place_on = "default:stone",
	sidelen = 16,
	fill_ratio = 10,
	biomes = {"snow_biome_alpine"},
	decoration = "default:snow",
})
]]--
