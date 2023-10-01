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
	-- Coast Banksia (big)
aus.schematics.coast_banksia_big_tree = {}
local max_r = 6
local ht = 7
local fruit = nil
local limbs = false
local tree = "australia:coast_banksia_tree"
local leaves = "australia:coast_banksia_leaves"
for r = 5,max_r do
	local schem = aus.generate_tree_schematic(3, {x=r, y=ht, z=r}, tree, leaves, fruit, limbs)
	push(aus.schematics.coast_banksia_big_tree, schem)
	minetest.register_decoration({
		deco_type = "schematic",
		sidelen = 80,
		place_on = {"default:dirt_with_grass"},
		y_min = 12,
		y_max = 35,
		fill_ratio = (max_r-r+1)/15000,
		biomes = {"eastern_coasts"},
		schematic = schem,
		flags = "place_center_x, place_center_z",
		rotation = "random",
	})
end
	-- Coast Banksia (small)
aus.schematics.coast_banksia_small_tree = {}
local max_r = 4
local ht = 4
local fruit = nil
local limbs = false
local tree = "australia:coast_banksia_tree"
local leaves = "australia:coast_banksia_leaves"
for r = 3,max_r do
	local schem = aus.generate_tree_schematic(1, {x=r, y=ht, z=r}, tree, leaves, fruit, limbs)
	push(aus.schematics.coast_banksia_small_tree, schem)
	minetest.register_decoration({
		deco_type = "schematic",
		sidelen = 80,
		place_on = {"default:dirt_with_grass"},
		y_min = 6,
		y_max = 10,
		fill_ratio = (max_r-r+1)/12000,
		biomes = {"eastern_coasts"},
		schematic = schem,
		flags = "place_center_x, place_center_z",
		rotation = "random",
	})
end
]]--
