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
aus.schematics.black_box_tree = {}
local max_r = 8
local ht = 8
local fruit = nil
local limbs = nil
local tree = "australia:black_box_tree"
local leaves = "australia:black_box_leaves"
for r = 6,max_r do
	local schem = aus.generate_big_tree_schematic(4, {x=r, y=ht, z=r}, tree, leaves, fruit, limbs)
	push(aus.schematics.black_box_tree, schem)
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
]]--
