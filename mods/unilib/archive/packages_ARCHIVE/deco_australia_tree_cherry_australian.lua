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
aus.schematics.cherry_tree = {}
local max_r = 3
local fruit = "australia:cherry"
local tree = "australia:cherry_tree"
local leaves = "australia:cherry_leaves"
for r = 2,max_r do
	local schem = aus.generate_conifer_schematic(3, 2, tree, leaves, fruit)
	push(aus.schematics.cherry_tree, schem)
	minetest.register_decoration({
		deco_type = "schematic",
		sidelen = 80,
		place_on = {"default:dirt_with_grass"},
		y_min = 7,
		y_max = 35,
		fill_ratio = (max_r-r+1)/15000,
		biomes = {"eastern_coasts"},
		schematic = schem,
		flags = "place_center_x, place_center_z",
		rotation = "random",
	})
end

aus.schematics.cherry_tree = {}
local max_r = 3
local fruit = "australia:cherry"
local tree = "australia:cherry_tree"
local leaves = "australia:cherry_leaves"
for r = 2,max_r do
	local schem = aus.generate_conifer_schematic(3, 2, tree, leaves, fruit)
	push(aus.schematics.cherry_tree, schem)
	minetest.register_decoration({
		deco_type = "schematic",
		sidelen = 80,
		place_on = {"default:dirt_with_dry_grass"},
		y_min = 36,
		y_max = 120,
		fill_ratio = (max_r-r+1)/15000,
		biomes = {"great_dividing_range"},
		schematic = schem,
		flags = "place_center_x, place_center_z",
		rotation = "random",
	})
end

aus.schematics.cherry_tree = {}
local max_r = 3
local fruit = "australia:cherry"
local tree = "australia:cherry_tree"
local leaves = "australia:cherry_leaves"
for r = 2,max_r do
	local schem = aus.generate_conifer_schematic(3, 2, tree, leaves, fruit)
	push(aus.schematics.cherry_tree, schem)
	minetest.register_decoration({
		deco_type = "schematic",
		sidelen = 80,
		place_on = {"default:dirt_with_grass"},
		y_min = 36,
		y_max = 150,
		fill_ratio = (max_r-r+1)/15000,
		biomes = {"great_dividing_range"},
		schematic = schem,
		flags = "place_center_x, place_center_z",
		rotation = "random",
	})
end
]]--
