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
	minetest.register_node("lib_ecology:plant_bananaplant2", {
		description = S("Plant - Banana Plant2"),
		drawtype = "mesh",
		mesh = "fern_old.b3d",
		visual_scale = 1.2,
		tiles = {"lib_ecology_plant_banana_plant.png"},
		paramtype = "light",
		paramtype2 = "degrotate",
		sunlight_propagates = true,
		waving = 1,
		walkable = false,
		floodable = true,
		buildable_to = true,
		groups = {snappy = 3, flora = 1, attached_node = 1, flammable = 2},
		sounds = default.node_sound_leaves_defaults(),
		selection_box = {
			type = "fixed",
			fixed = {-0.3, -0.5, -0.3, 0.3, 1, 0.3}
		},
	})
]]--
