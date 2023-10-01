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
minetest.register_node("better_farming:asparagus_crate", {
	description = "Asparagus Crate",
	tiles = {"asparagus_crate_top.png", "crate_bottom.png", "asparagus_crate_side.png",
		"asparagus_crate_side.png", "asparagus_crate_side.png", "asparagus_crate_side.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
})
minetest.register_craft({
	output = "better_farming:asparagus_crate",
	recipe = {
		{"better_farming:aspargus", "better_farming:aspargus", "better_farming:aspargus"},
		{"better_farming:aspargus", "group:wood", "better_farming:aspargus"},
		{"better_farming:aspargus", "better_farming:aspargus", "better_farming:aspargus"},
	}
})
]]--
