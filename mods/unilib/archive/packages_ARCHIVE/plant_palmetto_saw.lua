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
	minetest.register_node("lib_ecology:plant_palmetto_01", { -- deco
		description = S("Plant - Palmetto 01"),
		drawtype = "plantlike",
		tiles = {"lib_ecology_plant_palmetto_01.png"},
		paramtype = "light",
		is_ground_content = false,
		buildable_to = true, 
		sunlight_propagates = true,
		visual_scale = 1.2,
		wield_scale = {x=0.5, y=0.5, z=0.5},
		floodable = true,
		groups = {snappy=3, flammable=1, attatched_node=1, flora=1},
		sounds = default.node_sound_leaves_defaults(),
		selection_box = {
			type = "fixed",
			fixed = {-0.3, -0.5, -0.3, 0.3, 1, 0.3}
		},
		walkable = false,
	})
]]--
