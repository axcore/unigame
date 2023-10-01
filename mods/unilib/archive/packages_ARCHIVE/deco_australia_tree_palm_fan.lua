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
aus.schematics.fan_palm_tree = {}
local max_ht = 9
local r = 3
local tree = "australia:fan_palm_tree"
local leaves = "australia:fan_palm_leaves"
for h = 9,max_ht do
	local schem = aus.generate_fanpalm_tree_schematic(max_ht, r, tree, leaves)
	push(aus.schematics.fan_palm_tree, schem)
	minetest.register_decoration({
		deco_type = "schematic",
		sidelen = 80,
		place_on = {"default:dirt_with_grass"},
		fill_ratio = (max_ht-r+1)/300,
		biomes = {"far_north_queensland"},
		y_min = 5,
		y_max = 20,
		schematic = schem,
		flags = "place_center_x, place_center_z",
		rotation = "random",
	})
end
]]--
