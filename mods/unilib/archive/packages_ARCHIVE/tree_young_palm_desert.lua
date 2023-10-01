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
	minetest.register_node("lib_ecology:tree_desert_palm", { -- deco
		description = S("Plant - Desert Palm Tree"),
		drawtype = "plantlike",
		tiles = {"lib_ecology_plant_desert_palm.png"},
		paramtype = "light",
		is_ground_content = false,
		buildable_to = true, 
		sunlight_propagates = true,
		visual_scale = 2,
		wield_scale = {x=0.5, y=0.5, z=0.5},
		floodable = true,
		groups = {snappy=3, flammable=1, attatched_node=1, flora=1},
		sounds = default.node_sound_leaves_defaults(),
		selection_box = {
			type = "fixed",
			fixed = {-0.2, -0.5, -0.2, 0.2, 1, 0.2}
		},
		walkable = false,
	})
]]--
