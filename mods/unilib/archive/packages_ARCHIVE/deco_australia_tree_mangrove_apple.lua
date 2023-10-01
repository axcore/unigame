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
aus.schematics.mangrove_apple_tree = {}
local max_r = 5
local ht = 4
local fruit = "australia:mangrove_apple"
local limbs = false
local tree = "australia:mangrove_apple_tree"
local leaves = "australia:mangrove_apple_leaves"
for r = 3,max_r do
	local schem = aus.generate_tree_schematic(1, {x=r, y=ht, z=r}, tree, leaves, fruit, limbs)
	push(aus.schematics.mangrove_apple_tree, schem)
	minetest.register_decoration({
		deco_type = "schematic",
		sidelen = 80,
		place_on = {"australia:mangrove_mud", "default:dirt", "default:sand"},
		y_min = 0,
		y_max = 3,
		fill_ratio = (max_r-r+1)/5000,
		biomes = {"mangroves"},
		schematic = schem,
		flags = "place_center_x, place_center_z",
		rotation = "random",
	})
end
]]--
