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
{"golden_wattle", "Acacia pycnantha: Golden Wattle", 0.33, "acacia", nil, nil, nil, ntil },

aus.schematics.golden_wattle_tree = {}
local max_r = 3
local ht = 3
local fruit = nil
local limbs = false
local tree = "australia:golden_wattle_tree"
local leaves = "australia:golden_wattle_leaves"
for r = 2,max_r do
	local schem = aus.generate_tree_schematic(2, {x=r, y=ht, z=r}, tree, leaves, fruit, limbs)
	push(aus.schematics.golden_wattle_tree, schem)
	minetest.register_decoration({
		deco_type = "schematic",
		sidelen = 80,
		place_on = {"default:dirt_with_dry_grass"},
		y_min = 36,
		y_max = 170,
		fill_ratio = (max_r-r+1)/12000,
		biomes = {"flinders_lofty"},
		schematic = schem,
		flags = "place_center_x, place_center_z",
		rotation = "random",
	})
end

aus.schematics.golden_wattle_tree = {}
local max_r = 3
local ht = 3
local fruit = nil
local limbs = false
local tree = "australia:golden_wattle_tree"
local leaves = "australia:golden_wattle_leaves"
for r = 2,max_r do
	local schem = aus.generate_tree_schematic(2, {x=r, y=ht, z=r}, tree, leaves, fruit, limbs)
	push(aus.schematics.golden_wattle_tree, schem)
	minetest.register_decoration({
		deco_type = "schematic",
		sidelen = 80,
		place_on = {"default:dirt_with_dry_grass"},
		y_min = 36,
		y_max = 150,
		fill_ratio = (max_r-r+1)/15000,
		biomes = {"murray_darling_basin"},
		schematic = schem,
		flags = "place_center_x, place_center_z",
		rotation = "random",
	})
end

aus.schematics.golden_wattle_tree = {}
local max_r = 3
local ht = 3
local fruit = nil
local limbs = false
local tree = "australia:golden_wattle_tree"
local leaves = "australia:golden_wattle_leaves"
for r = 2,max_r do
	local schem = aus.generate_tree_schematic(2, {x=r, y=ht, z=r}, tree, leaves, fruit, limbs)
	push(aus.schematics.golden_wattle_tree, schem)
	minetest.register_decoration({
		deco_type = "schematic",
		sidelen = 80,
		place_on = {"default:dirt_with_grass"},
		y_min = 36,
		y_max = 150,
		fill_ratio = (max_r-r+1)/10000,
		biomes = {"great_dividing_range"},
		schematic = schem,
		flags = "place_center_x, place_center_z",
		rotation = "random",
	})
end

aus.schematics.golden_wattle_tree = {}
local max_r = 3
local ht = 3
local fruit = nil
local limbs = false
local tree = "australia:golden_wattle_tree"
local leaves = "australia:golden_wattle_leaves"
for r = 2,max_r do
	local schem = aus.generate_tree_schematic(2, {x=r, y=ht, z=r}, tree, leaves, fruit, limbs)
	push(aus.schematics.golden_wattle_tree, schem)
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
