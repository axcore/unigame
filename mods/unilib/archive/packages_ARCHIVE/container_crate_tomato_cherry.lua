---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    better_farming
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("better_farming:tomato_crate", {
	description = "Tomato Crate",
	tiles = {"tomato_crate_top.png", "crate_bottom.png", "tomato_crate_side.png",
		"tomato_crate_side.png", "tomato_crate_side.png", "tomato_crate_side.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
})
minetest.register_craft({
	output = "better_farming:tomato_crate",
	recipe = {
		{"better_farming:tomatoes", "better_farming:tomatoes", "better_farming:tomatoes"},
		{"better_farming:tomatoes", "group:wood", "better_farming:tomatoes"},
		{"better_farming:tomatoes", "better_farming:tomatoes", "better_farming:tomatoes"},
	}
})
]]--
