---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bbq
-- Code:    LGPL-2.1+
-- Media:   CC-BY-SA-3.0/CC-BY-3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("bbq:smoker_blueprint", {
	description = "Smoker Blueprint",
	inventory_image = "bbq_smoker_blueprint.png",
	tiles = {
		"default_pine_wood.png", "default_pine_wood.png",
		"default_pine_wood.png", "default_pine_wood.png",
		"default_pine_wood.png", "bbq_smoker_blueprint.png",
	},

	paramtype2 = "facedir",
	paramtype = "light",
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
				{-0.5, -0.5, 0.4, 0.5, 0.5, 0.5},

			},
		},
	groups = {choppy=3, oddly_breakable_by_hand=2, flammable=3},
	sounds = default.node_sound_wood_defaults(),
})
minetest.register_craft( {
	output = "bbq:smoker_blueprint",
	recipe = {
		{"group:wood", "group:wood", "group:wood"},
		{"group:wood", "dye:blue", "group:wood"},
		{"group:wood", "group:wood", "group:wood"},
	}
})
]]--
