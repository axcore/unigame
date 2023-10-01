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
aus.schematics.merbau_tree = {}
local max_ht = 12
local r = 8
local tree = "australia:merbau_tree"
local leaves = "australia:merbau_leaves"
for h = 8,max_ht do
	local schem = aus.generate_rainforest_tree_schematic(max_ht, r, tree, leaves)
	push(aus.schematics.merbau_tree, schem)
	minetest.register_decoration({
		deco_type = "schematic",
		sidelen = 80,
		place_on = {"default:dirt_with_grass"},
		fill_ratio = (max_ht-r+1)/6000,
		biomes = {"far_north_queensland"},
		y_min = 6,
		y_max = 25,
		schematic = schem,
		flags = "place_center_x, place_center_z",
		rotation = "random",
	})
end
]]--
