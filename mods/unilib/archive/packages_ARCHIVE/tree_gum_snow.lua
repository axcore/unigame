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
{"snow_gum", "Eucalyptus pauciflora: Snow Gum", 1.0, "eucalyptus", nil, nil, nil, nil },

aus.schematics.snow_gum_tree = {}
local max_r = 4
local ht = 4
local fruit = nil
local limbs = nil
local tree = "australia:snow_gum_tree"
local leaves = "australia:snow_gum_leaves"
for r = 3,max_r do
	local schem = aus.generate_tree_schematic(1, {x=r, y=ht, z=r}, tree, leaves, fruit, limbs)
	push(aus.schematics.snow_gum_tree, schem)
	minetest.register_decoration({
		deco_type = "schematic",
		sidelen = 80,
		place_on = {"default:snowblock"},
		y_min = 150,
		y_max = 180,
		fill_ratio = (max_r-r+1)/2500,
		biomes = {"australian_alps"},
		schematic = schem,
		flags = "place_center_x, place_center_z",
		rotation = "random",
	})
end

minetest.register_decoration({
	deco_type = "schematic",
	place_on = {"default:snowblock"},
	sidelen = 16,
	noise_params = {
		offset = 0.0018,
		scale = 0.0011,
		spread = {x = 250, y = 250, z = 250},
		seed = 34,
		octaves = 3,
		persist = 0.66
	},
	biomes = {"australian_alps"},
	y_min = 150,
	y_max = 170,
	schematic = {
		size = {x = 3, y = 3, z = 1},
		data = {
			{name = "air", prob = 0},
			{name = "air", prob = 0},
			{name = "air", prob = 0},
			{name = "australia:snow_gum_tree", param2 = 12, prob = 191},
			{name = "australia:snow_gum_tree", param2 = 12},
			{name = "australia:snow_gum_tree", param2 = 12, prob = 127},
			{name = "air", prob = 0},
			{name = "flowers:mushroom_brown", prob = 63},
			{name = "air", prob = 0},
		},
	},
	flags = "place_center_x",
	rotation = "random",
})
]]--
