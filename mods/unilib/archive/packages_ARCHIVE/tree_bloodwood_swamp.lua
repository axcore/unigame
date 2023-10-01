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
{"swamp_bloodwood", "Corymbia ptychocarpa: Swamp Bloodwood", 1.0, "eucalyptus", nil, nil, nil, nil },

aus.schematics.swamp_bloodwood_tree = {}
local max_r = 4
local ht = 6
local fruit = nil
local limbs = nil
local tree = "australia:swamp_bloodwood_tree"
local leaves = "australia:swamp_bloodwood_leaves"
for r = 3,max_r do
	local schem = aus.generate_tree_schematic(3, {x=r, y=ht, z=r}, tree, leaves, fruit, limbs)
	push(aus.schematics.swamp_bloodwood_tree, schem)
	minetest.register_decoration({
		deco_type = "schematic",
		sidelen = 80,
		place_on = {"australia:red_dirt"},
		y_min = 7,
		y_max = 35,
		fill_ratio = (max_r-r+1)/10000,
		biomes = {"kimberley"},
		schematic = schem,
		flags = "place_center_x, place_center_z",
		rotation = "random",
	})
end
]]--
