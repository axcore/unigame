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
	minetest.register_node("lib_ecology:fern_ladyfern2", { 
		description = S("Fern - Ladyfern2"),
		drawtype = "plantlike",
		visual_scale = 1.0,
		tiles = {"lib_ecology_fern_04.png",},
		paramtype = "light",
		paramtype2 = "degrotate",
		waving = 1,
		walkable = false,
		floodable = true,
		buildable_to = true,
		groups = {snappy = 3, oddly_breakable_by_hand = 1, flora = 1, flammable = 1},
		sounds = default.node_sound_leaves_defaults(),
		selection_box = {
			type = "fixed",
			fixed = {-0.3, -0.5, -0.3, 0.3, 0.3, 0.3}
		},
	})
]]--
