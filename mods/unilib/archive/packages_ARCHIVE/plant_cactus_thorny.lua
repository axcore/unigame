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
	minetest.register_node("lib_ecology:plant_cactus_03", {
		description = S("Cactus - Thorny"),
		drawtype = "mesh",
		mesh = "cactus.b3d",
		paramtype = "light",
		tiles = {
			"lib_ecology_plant_cactus.png",
		},
		visual_scale = 0.5,
		selection_box = {
			type = "fixed",
			fixed = {-0.4, -0.5, -0.4, 0.4, 0.5, 0.4},
		},
		collision_box = {
			type = "fixed",
			fixed = {-0.4, -0.5, -0.4, 0.4, 0.5, 0.4},
		},
		groups = {choppy = 1, oddly_breakable_by_hand = 1},
		sounds = default.node_sound_wood_defaults()
	})
]]--
