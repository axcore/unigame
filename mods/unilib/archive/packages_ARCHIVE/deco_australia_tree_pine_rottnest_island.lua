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
aus.schematics.rottnest_island_pine_tree = {}
local max_r = 3
local fruit = nil
local tree = "australia:rottnest_island_pine_tree"
local leaves = "australia:rottnest_island_pine_leaves"
for r = 2,max_r do
	local schem = aus.generate_conifer_schematic(3, 2, tree, leaves, fruit)
	push(aus.schematics.rottnest_island_pine_tree, schem)
	minetest.register_decoration({
		deco_type = "schematic",
		sidelen = 80,
		place_on = {"default:dirt_with_grass"},
		y_min = 6,
		y_max = 20,
		fill_ratio = (max_r-r+1)/10000,
		biomes = {"jarrah_karri_forests"},
		schematic = schem,
		flags = "place_center_x, place_center_z",
		rotation = "random",
	})
end
]]--
