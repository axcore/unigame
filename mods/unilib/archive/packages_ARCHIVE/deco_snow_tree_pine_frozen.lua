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
--Pine tree.
minetest.register_decoration({
	deco_type = "schematic",
	place_on = "default:dirt_with_snow",
	sidelen = 16,
	fill_ratio = 0.005,
	biomes = {"snow_biome_default"},
	schematic = minetest.get_modpath("snow").."/schematics/pine.mts",
	flags = "place_center_x, place_center_z",
})

minetest.register_decoration({
	deco_type = "schematic",
	place_on = "default:dirt_with_snow",
	sidelen = 16,
	fill_ratio = 0.05,
	biomes = {"snow_biome_forest"},
	schematic = minetest.get_modpath("snow").."/schematics/pine.mts",
	flags = "place_center_x, place_center_z",
})

minetest.register_decoration({
	deco_type = "schematic",
	place_on = "default:dirt_with_snow",
	sidelen = 16,
	fill_ratio = 0.1,
	biomes = {"snow_biome_lush"},
	schematic = minetest.get_modpath("snow").."/schematics/pine.mts",
	flags = "place_center_x, place_center_z",
})
]]--
