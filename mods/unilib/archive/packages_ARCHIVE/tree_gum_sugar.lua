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
{"sugar_gum", "Eucalyptus cladocalyx: Sugar Gum", 1.0, "eucalyptus", nil, nil, nil, nil },

aus.schematics.sugar_gum_tree = {}
local max_r = 11
local ht = 10
local fruit = nil
local limbs = nil
local tree = "australia:sugar_gum_tree"
local leaves = "australia:sugar_gum_leaves"
for r = 9,max_r do
	local schem = aus.generate_tree_schematic(8, {x=r, y=ht, z=r}, tree, leaves, fruit, limbs)
	push(aus.schematics.sugar_gum_tree, schem)
	minetest.register_decoration({
		deco_type = "schematic",
		sidelen = 80,
		place_on = {"australia:red_dirt"},
		y_min = 36,
		y_max = 140,
		fill_ratio = (max_r-r+1)/20000,
		biomes = {"central_australia"},
		schematic = schem,
		flags = "place_center_x, place_center_z",
		rotation = "random",
	})
end

aus.schematics.sugar_gum_tree = {}
local max_r = 11
local ht = 10
local fruit = nil
local limbs = nil
local tree = "australia:sugar_gum_tree"
local leaves = "australia:sugar_gum_leaves"
for r = 9,max_r do
	local schem = aus.generate_tree_schematic(8, {x=r, y=ht, z=r}, tree, leaves, fruit, limbs)
	push(aus.schematics.sugar_gum_tree, schem)
	minetest.register_decoration({
		deco_type = "schematic",
		sidelen = 80,
		place_on = {"default:dirt_with_dry_grass"},
		y_min = 36,
		y_max = 150,
		fill_ratio = (max_r-r+1)/10000,
		biomes = {"flinders_lofty"},
		schematic = schem,
		flags = "place_center_x, place_center_z",
		rotation = "random",
	})
end
]]--
