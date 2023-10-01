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
aus.schematics.daintree_stringybark_tree = {}
local max_r = 7
local ht = 10
local fruit = nil
local limbs = nil
local tree = "australia:daintree_stringybark_tree"
local leaves = "australia:daintree_stringybark_leaves"
for r = 6,max_r do
	local schem = aus.generate_tree_schematic(9, {x=r, y=ht, z=r}, tree, leaves, fruit, limbs)
	push(aus.schematics.daintree_stringybark_tree, schem)
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
