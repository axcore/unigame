---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr4
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
	minetest.register_node("lib_ecology:fern_giant_tree_leaves_2", {
		description = "Fern Giant Tree Leaves 2",
		drawtype = "raillike",
		paramtype = "light",
		tiles = {
			"lib_ecology_fern_giant_tree_leaves2.png",
		},
		walkable = false,
		groups = {snappy=3,flammable=2,attached_node=1,not_in_creative_inventory=1, leaves = 1, leafdecay = 1},
		drop = "",
		sounds = default.node_sound_leaves_defaults(),
	})
	minetest.register_node("lib_ecology:fern_giant_tree_leaves_end_2", {
		description = "Fern Giant Tree Leaves End 2",
		drawtype = "nodebox",
		paramtype = "light",
		paramtype2 = "facedir",
		tiles = { "lib_ecology_fern_giant_tree_leaves_end2.png" },     
		walkable = false,
		node_box = {
			type = "fixed",
	--			    {left, bottom, front, right, top,   back }
			fixed = {-1/2, -1/2,   1/2, 1/2,   33/64, 1/2},
		},
		selection_box = {
			type = "fixed",
			fixed = {-1/2, -1/2,   1/2, 1/2,   33/64, 1/2},
		},
		groups = {snappy=3,flammable=2,attached_node=1,not_in_creative_inventory=1, leaves = 1, leafdecay = 1},
		drop = "",
		sounds = default.node_sound_leaves_defaults(),
	})
]]--
