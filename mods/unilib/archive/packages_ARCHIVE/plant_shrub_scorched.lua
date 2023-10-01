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
	minetest.register_node("lib_ecology:plant_shrub_scorched", {
		description = S("Shrub - Scorched"),
		drawtype = "plantlike",
		visual_scale = 1.0,
		tiles = {"lib_ecology_plant_shrub_scorched.png"},
		paramtype = "light",
		is_ground_content = false,
		sunlight_propagates = false,
		groups = {snappy=3, flammable=1, oddly_breakable_by_hand=1, leaves=1},
		visual_scale = 1.2,
		sounds = default.node_sound_leaves_defaults(),
		waving = 1,
		walkable = false,
		floodable = true,
		selection_box = {
			type = "fixed",
			fixed = {-0.4, -0.4, -0.4, 0.4, 0.4, 0.4}
		},
	})
]]--
