---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr6
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
	minetest.register_node("lib_ecology:plant_coral_pillar", {
		description = S("Plant - Coral Pillar"),
		drawtype = "nodebox",
		tiles = {"lib_ecology_plant_coral_pillar.png"},
		paramtype = "light",
		light_source = 2,
		drop = "lib_ecology:plant_coral_skeleton",
		groups = {cracky = 3, stone=1, sea=1},
		sounds = lib_ecology.node_sound_stone_defaults(),
		node_box = {
			type = "fixed", 
			fixed = grid,
		},
		selection_box = {
			type = "fixed", 
			fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
		},
	})
]]--
