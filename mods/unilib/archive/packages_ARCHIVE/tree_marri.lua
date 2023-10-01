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
{"marri", "Corymbia calophylla: Marri", 1.0, "eucalyptus", nil, nil, nil, nil },

aus.schematics.marri_tree = {}
local max_r = 10
local ht = 12
local fruit = nil
local limbs = nil
local tree = "australia:marri_tree"
local leaves = "australia:marri_leaves"
for r = 8,max_r do
	local schem = aus.generate_big_tree_schematic(8, {x=r, y=ht, z=r}, tree, leaves, fruit, limbs)
	push(aus.schematics.marri_tree, schem)
	minetest.register_decoration({
		deco_type = "schematic",
		sidelen = 80,
		place_on = {"default:dirt_with_grass"},
		y_min = 12,
		y_max = 35,
		fill_ratio = (max_r-r+1)/10000,
		biomes = {"jarrah_karri_forests"},
		schematic = schem,
		flags = "place_center_x, place_center_z",
		rotation = "random",
	})
end
]]--
