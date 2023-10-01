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
aus.schematics.desert_oak_tree = {}
local max_r = 8
local ht = 5
local fruit = nil
local limbs = nil
local tree = "australia:desert_oak_tree"
local leaves = "australia:desert_oak_leaves"
for r = 6,max_r do
	local schem = aus.generate_tree_schematic(6, {x=r, y=ht, z=r}, tree, leaves, fruit, limbs)
	push(aus.schematics.desert_oak_tree, schem)
	minetest.register_decoration({
		deco_type = "schematic",
		sidelen = 80,
		place_on = {"australia:red_dirt"},
		y_min = 36,
		y_max = 140,
		fill_ratio = (max_r-r+1)/15000,
		biomes = {"central_australia"},
		schematic = schem,
		flags = "place_center_x, place_center_z",
		rotation = "random",
	})
end

aus.schematics.desert_oak_tree = {}
local max_r = 8
local ht = 5
local fruit = nil
local limbs = nil
local tree = "australia:desert_oak_tree"
local leaves = "australia:desert_oak_leaves"
for r = 6,max_r do
	local schem = aus.generate_tree_schematic(6, {x=r, y=ht, z=r}, tree, leaves, fruit, limbs)
	push(aus.schematics.desert_oak_tree, schem)
	minetest.register_decoration({
		deco_type = "schematic",
		sidelen = 80,
		place_on = {"australia:red_gravel"},
		y_min = 10,
		y_max = 35,
		fill_ratio = (max_r-r+1)/20000,
		biomes = {"pilbara"},
		schematic = schem,
		flags = "place_center_x, place_center_z",
		rotation = "random",
	})
end
]]--
