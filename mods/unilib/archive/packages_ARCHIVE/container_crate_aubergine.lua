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
minetest.register_node("better_farming:eggplant_crate", {
	description = "Eggplants Crate",
	tiles = {"eggplant_crate_top.png", "crate_bottom.png", "eggplant_crate_side.png",
		"eggplant_crate_side.png", "eggplant_crate_side.png", "eggplant_crate_side.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
})
minetest.register_craft({
	output = "better_farming:eggplant_crate",
	recipe = {
		{"better_farming:eggplants", "better_farming:eggplants", "better_farming:eggplants"},
		{"better_farming:eggplants", "group:wood", "better_farming:eggplants"},
		{"better_farming:eggplants", "better_farming:eggplants", "better_farming:eggplants"},
	}
})
]]--
