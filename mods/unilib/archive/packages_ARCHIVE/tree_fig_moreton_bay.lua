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
{"moreton_bay_fig", "Ficus macrophylla: Moreton Bay Fig", 1.0, "fig", "moreton_bay_fig", "Moreton Bay Fig", 0.67, 1 },

aus.schematics.moreton_bay_fig_tree = {}
local max_r = 13
local ht = 12
local fruit = "australia:moreton_bay_fig"
local limbs = nil
local tree = "australia:moreton_bay_fig_tree"
local leaves = "australia:moreton_bay_fig_leaves"
for r = 11,max_r do
	local schem = aus.generate_giant_tree_schematic(2, {x=r, y=ht, z=r}, tree, leaves, fruit, limbs)
	push(aus.schematics.moreton_bay_fig_tree, schem)
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
