---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
	minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"mapgen:dirt_with_junglegrass", "default:dirt"},
		sidelen = 80,
		fill_ratio = 0.03,
		biomes = {"rainforest",},
		y_min = -1,
		y_max = 31000,
		schematic = minetest.get_modpath("mapgen") .. "/schematics/jungletree.mts",
		flags = "place_center_x, place_center_z",
		rotation = "random",
	})

	minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"mapgen:dirt_with_junglegrass", "default:dirt"},
		sidelen = 80,
		fill_ratio = 0.03,
		biomes = {"rainforest_swamp"},
		y_min = -1,
		y_max = 31000,
		schematic = minetest.get_modpath("default") .. "/schematics/jungle_tree.mts",
		flags = "place_center_x, place_center_z",
		rotation = "random",
	})

	minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"mapgen:dirt_with_junglegrass", "default:dirt"},
		sidelen = 80,
		fill_ratio = 0.03,
		biomes = {"rainforest",},
		y_min = -1,
		y_max = 31000,
		schematic = minetest.get_modpath("mapgen") .. "/schematics/junglepalm.mts",
		flags = "place_center_x, place_center_z",
		rotation = "random",
	})
]]--
