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
aus.schematics.swamp_gum_tree = {}
local max_r = 6
local ht = 18
local fruit = nil
local limbs = nil
local tree = "australia:swamp_gum_tree"
local leaves = "australia:swamp_gum_leaves"
for r = 6,max_r do
	local schem = aus.generate_giant_tree_schematic(26, {x=r, y=ht, z=r}, tree, leaves, fruit, limbs)
	push(aus.schematics.swamp_gum_tree, schem)
	minetest.register_decoration({
		deco_type = "schematic",
		sidelen = 80,
		place_on = {"default:dirt_with_grass"},
		y_min = 36,
		y_max = 120,
		fill_ratio = (max_r-r+1)/10000,
		biomes = {"tasmania"},
		schematic = schem,
		flags = "place_center_x, place_center_z",
		rotation = "random",
	})
end

aus.schematics.swamp_gum_tree = {}
local max_r = 6
local ht = 18
local fruit = nil
local limbs = nil
local tree = "australia:swamp_gum_tree"
local leaves = "australia:swamp_gum_leaves"
for r = 6,max_r do
	local schem = aus.generate_giant_tree_schematic(26, {x=r, y=ht, z=r}, tree, leaves, fruit, limbs)
	push(aus.schematics.swamp_gum_tree, schem)
	minetest.register_decoration({
		deco_type = "schematic",
		sidelen = 80,
		place_on = {"default:dirt_with_grass"},
		y_min = 36,
		y_max = 120,
		fill_ratio = (max_r-r+1)/15000,
		biomes = {"victorian_forests"},
		schematic = schem,
		flags = "place_center_x, place_center_z",
		rotation = "random",
	})
end
]]--
