---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
local n1 = { name = "air", prob = 0 }
local n2 = { name = "australia:tree_fern_leaf_big_end" }
local n3 = { name = "australia:tree_fern_leaf_big" }
local n4 = { name = "australia:fern_trunk_big" }
local n5 = { name = "australia:tree_fern_leaf_big_end", param2 = 1 }
local n6 = { name = "australia:fern_trunk_big_top" }
local n7 = { name = "australia:tree_fern_leaf_big_end", param2 = 3 }
local n8 = { name = "australia:tree_fern_leaves_giant" }
local n9 = { name = "australia:tree_fern_leaf_big_end", param2 = 2 }
minetest.register_decoration({
	deco_type = "schematic",
	sidelen = 80,
	place_on = {"default:dirt_with_grass"},
	y_min = 36,
	y_max = 70,
	fill_ratio = 0.002,
	biomes = {"great_dividing_range"},
	schematic = {
		size = {y = 7, x = 9, z = 9},
	data = {
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n2, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n3, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n3, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n3, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n4, n1, n1, n1, n1, n1, n1, n1, n1, n4, n1, n1, n1, n1, n1, n1, 
			n1, n1, n4, n1, n1, n1, n1, n1, n1, n1, n1, n4, n1, n1, n1, n1, n5, 
			n1, n1, n1, n6, n1, n1, n1, n7, n1, n3, n1, n3, n8, n3, n1, n3, n1, 
			n1, n1, n3, n1, n1, n1, n3, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n3, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n3, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n3, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n9, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, 
			},
		yslice_prob = {},
	},
	flags = "place_center_x, place_center_z",
})

	-- Big Tree Fern
    --[[
local n1 = { name = "air", prob = 0 }
local n2 = { name = "australia:tree_fern_leaf_big_end" }
local n3 = { name = "australia:tree_fern_leaf_big" }
local n4 = { name = "australia:fern_trunk_big" }
local n5 = { name = "australia:tree_fern_leaf_big_end", param2 = 1 }
local n6 = { name = "australia:fern_trunk_big_top" }
local n7 = { name = "australia:tree_fern_leaf_big_end", param2 = 3 }
local n8 = { name = "australia:tree_fern_leaves_giant" }
local n9 = { name = "australia:tree_fern_leaf_big_end", param2 = 2 }
minetest.register_decoration({
	deco_type = "schematic",
	sidelen = 80,
	place_on = {"default:dirt_with_grass"},
	y_min = 6,
	y_max = 20,
	fill_ratio = 0.003,
	biomes = {"far_north_queensland"},
	schematic = {
		size = {y = 7, x = 9, z = 9},
	data = {
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n2, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n3, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n3, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n3, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n4, n1, n1, n1, n1, n1, n1, n1, n1, n4, n1, n1, n1, n1, n1, n1, 
			n1, n1, n4, n1, n1, n1, n1, n1, n1, n1, n1, n4, n1, n1, n1, n1, n5, 
			n1, n1, n1, n6, n1, n1, n1, n7, n1, n3, n1, n3, n8, n3, n1, n3, n1, 
			n1, n1, n3, n1, n1, n1, n3, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n3, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n3, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n3, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n9, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, 
			},
		yslice_prob = {},
	},
	flags = "place_center_x, place_center_z",
})

local n1 = { name = "air", prob = 0 }
local n2 = { name = "australia:tree_fern_leaf_big_end" }
local n3 = { name = "australia:tree_fern_leaf_big" }
local n4 = { name = "australia:fern_trunk_big" }
local n5 = { name = "australia:tree_fern_leaf_big_end", param2 = 1 }
local n6 = { name = "australia:fern_trunk_big_top" }
local n7 = { name = "australia:tree_fern_leaf_big_end", param2 = 3 }
local n8 = { name = "australia:tree_fern_leaves_giant" }
local n9 = { name = "australia:tree_fern_leaf_big_end", param2 = 2 }
minetest.register_decoration({
	deco_type = "schematic",
	sidelen = 80,
	place_on = {"default:dirt_with_grass"},
	y_min = 36,
	y_max = 70,
	fill_ratio = 0.006,
	biomes = {"tasmania"},
	schematic = {
		size = {y = 7, x = 9, z = 9},
	data = {
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n2, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n3, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n3, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n3, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n4, n1, n1, n1, n1, n1, n1, n1, n1, n4, n1, n1, n1, n1, n1, n1, 
			n1, n1, n4, n1, n1, n1, n1, n1, n1, n1, n1, n4, n1, n1, n1, n1, n5, 
			n1, n1, n1, n6, n1, n1, n1, n7, n1, n3, n1, n3, n8, n3, n1, n3, n1, 
			n1, n1, n3, n1, n1, n1, n3, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n3, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n3, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n3, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n9, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, 
			},
		yslice_prob = {},
	},
	flags = "place_center_x, place_center_z",
})

local n1 = { name = "air", prob = 0 }
local n2 = { name = "australia:tree_fern_leaf_big_end" }
local n3 = { name = "australia:tree_fern_leaf_big" }
local n4 = { name = "australia:fern_trunk_big" }
local n5 = { name = "australia:tree_fern_leaf_big_end", param2 = 1 }
local n6 = { name = "australia:fern_trunk_big_top" }
local n7 = { name = "australia:tree_fern_leaf_big_end", param2 = 3 }
local n8 = { name = "australia:tree_fern_leaves_giant" }
local n9 = { name = "australia:tree_fern_leaf_big_end", param2 = 2 }
minetest.register_decoration({
	deco_type = "schematic",
	sidelen = 80,
	place_on = {"default:dirt_with_grass"},
	y_min = 36,
	y_max = 70,
	fill_ratio = 0.004,
	biomes = {"victorian_forests"},
	schematic = {
		size = {y = 7, x = 9, z = 9},
	data = {
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n2, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n3, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n3, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n3, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n4, n1, n1, n1, n1, n1, n1, n1, n1, n4, n1, n1, n1, n1, n1, n1, 
			n1, n1, n4, n1, n1, n1, n1, n1, n1, n1, n1, n4, n1, n1, n1, n1, n5, 
			n1, n1, n1, n6, n1, n1, n1, n7, n1, n3, n1, n3, n8, n3, n1, n3, n1, 
			n1, n1, n3, n1, n1, n1, n3, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n3, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n3, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n3, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n9, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, 
			},
		yslice_prob = {},
	},
	flags = "place_center_x, place_center_z",
})
]]--
