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
{"stilted_mangrove", "Rhizophora stylosa: Stilted Mangrove", 0.25, "mangrove", nil, nil, nil, nil },

aus.schematics.stilted_mangrove_tree = {}
local max_ht = 6
local tree = "australia:stilted_mangrove_tree"
local leaves = "australia:stilted_mangrove_leaves"
for h = 4,max_ht do
	local schem = aus.generate_mangrove_tree_schematic(3, tree, leaves)
	push(aus.schematics.stilted_mangrove_tree, schem)
	minetest.register_decoration({
		deco_type = "schematic",
		sidelen = 80,
		place_on = {"australia:mangrove_mud", "default:dirt", "default:sand"},
		fill_ratio = 0.003,
		biomes = {"mangroves"},
		y_min = -2,
		y_max = 3,
		schematic = schem,
		flags = "place_center_x, place_center_z",
		rotation = "random",
	})
end
]]--
