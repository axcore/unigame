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
aus.schematics.celery_top_pine_tree = {}
local max_r = 5
local fruit = nil
local tree = "australia:celery_top_pine_tree"
local leaves = "australia:celery_top_pine_leaves"
for r = 4,max_r do
	local schem = aus.generate_conifer_schematic(5, 4, tree, leaves, fruit)
	push(aus.schematics.celery_top_pine_tree, schem)
	minetest.register_decoration({
		deco_type = "schematic",
		sidelen = 80,
		place_on = {"default:dirt_with_grass"},
		y_min = 36,
		y_max = 180,
		fill_ratio = (max_r-r+1)/8000,
		biomes = {"tasmania"},
		schematic = schem,
		flags = "place_center_x, place_center_z",
		rotation = "random",
	})
end
]]--
