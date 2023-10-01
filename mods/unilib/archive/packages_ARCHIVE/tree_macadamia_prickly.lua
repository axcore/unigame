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
{"macadamia", "Macadamia tetraphylla: Prickly Macadamia", 0.75, "macadamia", "macadamia", "Macadamia Nuts", 0.67, 1 },

aus.schematics.macadamia_tree = {}
local max_r = 6
local ht = 6
local fruit = "australia:macadamia"
local limbs = nil
local tree = "australia:macadamia_tree"
local leaves = "australia:macadamia_leaves"
for r = 4,max_r do
	local schem = aus.generate_tree_schematic(2, {x=r, y=ht, z=r}, tree, leaves, fruit, limbs)
	push(aus.schematics.macadamia_tree, schem)
	minetest.register_decoration({
		deco_type = "schematic",
		sidelen = 80,
		place_on = {"default:dirt_with_grass"},
		y_min = 8,
		y_max = 35,
		fill_ratio = (max_r-r+1)/15000,
		biomes = {"eastern_coasts"},
		schematic = schem,
		flags = "place_center_x, place_center_z",
		rotation = "random",
	})
end
]]--
