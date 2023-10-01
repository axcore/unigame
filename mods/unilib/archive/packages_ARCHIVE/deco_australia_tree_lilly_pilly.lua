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
aus.schematics.lilly_pilly_tree = {}
local max_r = 5
local ht = 8
local fruit = "australia:lilly_pilly_berries"
local limbs = false
local tree = "australia:lilly_pilly_tree"
local leaves = "australia:lilly_pilly_leaves"
for r = 4,max_r do
	local schem = aus.generate_tree_schematic(1, {x=r, y=ht, z=r}, tree, leaves, fruit, limbs)
	push(aus.schematics.lilly_pilly_tree, schem)
	minetest.register_decoration({
		deco_type = "schematic",
		sidelen = 80,
		place_on = {"default:dirt_with_grass"},
		y_min = 7,
		y_max = 35,
		fill_ratio = (max_r-r+1)/12000,
		biomes = {"eastern_coasts"},
		schematic = schem,
		flags = "place_center_x, place_center_z",
		rotation = "random",
	})
end

aus.schematics.lilly_pilly_tree = {}
local max_r = 5
local ht = 8
local fruit = "australia:lilly_pilly_berries"
local limbs = false
local tree = "australia:lilly_pilly_tree"
local leaves = "australia:lilly_pilly_leaves"
for r = 4,max_r do
	local schem = aus.generate_tree_schematic(1, {x=r, y=ht, z=r}, tree, leaves, fruit, limbs)
	push(aus.schematics.lilly_pilly_tree, schem)
	minetest.register_decoration({
		deco_type = "schematic",
		sidelen = 80,
		place_on = {"default:dirt_with_grass"},
		y_min = 20,
		y_max = 35,
		fill_ratio = (max_r-r+1)/12000,
		biomes = {"far_north_queensland"},
		schematic = schem,
		flags = "place_center_x, place_center_z",
		rotation = "random",
	})
end

aus.schematics.lilly_pilly_tree = {}
local max_r = 5
local ht = 8
local fruit = "australia:lilly_pilly_berries"
local limbs = false
local tree = "australia:lilly_pilly_tree"
local leaves = "australia:lilly_pilly_leaves"
for r = 4,max_r do
	local schem = aus.generate_tree_schematic(1, {x=r, y=ht, z=r}, tree, leaves, fruit, limbs)
	push(aus.schematics.lilly_pilly_tree, schem)
	minetest.register_decoration({
		deco_type = "schematic",
		sidelen = 80,
		place_on = {"default:dirt_with_grass"},
		y_min = 36,
		y_max = 150,
		fill_ratio = (max_r-r+1)/12000,
		biomes = {"great_dividing_range"},
		schematic = schem,
		flags = "place_center_x, place_center_z",
		rotation = "random",
	})
end

aus.schematics.lilly_pilly_tree = {}
local max_r = 5
local ht = 8
local fruit = "australia:lilly_pilly_berries"
local limbs = false
local tree = "australia:lilly_pilly_tree"
local leaves = "australia:lilly_pilly_leaves"
for r = 4,max_r do
	local schem = aus.generate_tree_schematic(1, {x=r, y=ht, z=r}, tree, leaves, fruit, limbs)
	push(aus.schematics.lilly_pilly_tree, schem)
	minetest.register_decoration({
		deco_type = "schematic",
		sidelen = 80,
		place_on = {"default:dirt_with_grass"},
		y_min = 36,
		y_max = 150,
		fill_ratio = (max_r-r+1)/12000,
		biomes = {"victorian_forests"},
		schematic = schem,
		flags = "place_center_x, place_center_z",
		rotation = "random",
	})
end
]]--
