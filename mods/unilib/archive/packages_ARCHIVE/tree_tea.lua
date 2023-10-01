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
{"tea_tree", "Melaleuca alternifolia: Tea", 0.5, "melaleuca", nil, nil, nil, nil },

aus.schematics.tea_tree_tree = {}
local max_r = 3
local ht = 4
local fruit = nil
local limbs = false
local tree = "australia:tea_tree_tree"
local leaves = "australia:tea_tree_leaves"
for r = 2,max_r do
	local schem = aus.generate_tree_schematic(1, {x=r, y=ht, z=r}, tree, leaves, fruit, limbs)
	push(aus.schematics.tea_tree_tree, schem)
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

aus.schematics.tea_tree_tree = {}
local max_r = 3
local ht = 4
local fruit = nil
local limbs = false
local tree = "australia:tea_tree_tree"
local leaves = "australia:tea_tree_leaves"
for r = 2,max_r do
	local schem = aus.generate_tree_schematic(1, {x=r, y=ht, z=r}, tree, leaves, fruit, limbs)
	push(aus.schematics.tea_tree_tree, schem)
	minetest.register_decoration({
		deco_type = "schematic",
		sidelen = 80,
		place_on = {"default:dirt_with_grass"},
		y_min = 36,
		y_max = 170,
		fill_ratio = (max_r-r+1)/12000,
		biomes = {"great_dividing_range"},
		schematic = schem,
		flags = "place_center_x, place_center_z",
		rotation = "random",
	})
end
]]--
