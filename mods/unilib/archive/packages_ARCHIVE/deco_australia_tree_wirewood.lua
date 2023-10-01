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
aus.schematics.wirewood_tree = {}
local max_r = 4
local ht = 4
local fruit = nil
local limbs = false
local tree = "australia:wirewood_tree"
local leaves = "australia:wirewood_leaves"
for r = 3,max_r do
	local schem = aus.generate_tree_schematic(2, {x=r, y=ht, z=r}, tree, leaves, fruit, limbs)
	push(aus.schematics.wirewood_tree, schem)
	minetest.register_decoration({
		deco_type = "schematic",
		sidelen = 80,
		place_on = {"australia:red_dirt"},
		y_min = 36,
		y_max = 150,
		fill_ratio = (max_r-r+1)/12000,
		biomes = {"central_australia"},
		schematic = schem,
		flags = "place_center_x, place_center_z",
		rotation = "random",
	})
end
]]--
