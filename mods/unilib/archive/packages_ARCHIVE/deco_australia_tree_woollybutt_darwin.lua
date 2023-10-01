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
aus.schematics.darwin_woollybutt_tree = {}
local max_r = 4
local ht = 5
local fruit = nil
local limbs = nil
local tree = "australia:darwin_woollybutt_tree"
local leaves = "australia:darwin_woollybutt_leaves"
for r = 3,max_r do
	local schem = aus.generate_tree_schematic(6, {x=r, y=ht, z=r}, tree, leaves, fruit, limbs)
	push(aus.schematics.darwin_woollybutt_tree, schem)
	minetest.register_decoration({
		deco_type = "schematic",
		sidelen = 80,
		place_on = {"default:dirt_with_grass"},
		y_min = 8,
		y_max = 35,
		fill_ratio = (max_r-r+1)/10000,
		biomes = {"arnhem_land"},
		schematic = schem,
		flags = "place_center_x, place_center_z",
		rotation = "random",
	})
end

aus.schematics.darwin_woollybutt_tree = {}
local max_r = 4
local ht = 5
local fruit = nil
local limbs = nil
local tree = "australia:darwin_woollybutt_tree"
local leaves = "australia:darwin_woollybutt_leaves"
for r = 3,max_r do
	local schem = aus.generate_tree_schematic(6, {x=r, y=ht, z=r}, tree, leaves, fruit, limbs)
	push(aus.schematics.darwin_woollybutt_tree, schem)
	minetest.register_decoration({
		deco_type = "schematic",
		sidelen = 80,
		place_on = {"default:dirt_with_dry_grass"},
		y_min = 8,
		y_max = 35,
		fill_ratio = (max_r-r+1)/12000,
		biomes = {"gulf_of_carpentaria"},
		schematic = schem,
		flags = "place_center_x, place_center_z",
		rotation = "random",
	})
end

for r = 3,max_r do
	local schem = aus.generate_tree_schematic(6, {x=r, y=ht, z=r}, tree, leaves, fruit, limbs)
	push(aus.schematics.darwin_woollybutt_tree, schem)
	minetest.register_decoration({
		deco_type = "schematic",
		sidelen = 80,
		place_on = {"australia:red_dirt"},
		y_min = 12,
		y_max = 35,
		fill_ratio = (max_r-r+1)/15000,
		biomes = {"kimberley"},
		schematic = schem,
		flags = "place_center_x, place_center_z",
		rotation = "random",
	})
end

aus.schematics.darwin_woollybutt_tree = {}
local max_r = 4
local ht = 5
local fruit = nil
local limbs = nil
local tree = "australia:darwin_woollybutt_tree"
local leaves = "australia:darwin_woollybutt_leaves"
for r = 3,max_r do
	local schem = aus.generate_tree_schematic(6, {x=r, y=ht, z=r}, tree, leaves, fruit, limbs)
	push(aus.schematics.darwin_woollybutt_tree, schem)
	minetest.register_decoration({
		deco_type = "schematic",
		sidelen = 80,
		place_on = {"default:dirt_with_grass"},
		y_min = 25,
		y_max = 35,
		fill_ratio = (max_r-r+1)/12000,
		biomes = {"far_north_queensland"},
		schematic = schem,
		flags = "place_center_x, place_center_z",
		rotation = "random",
	})
end
]]--
