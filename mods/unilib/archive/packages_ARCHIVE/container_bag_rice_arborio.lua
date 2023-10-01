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
minetest.register_node("better_farming:rice_crate", {
	description = "Rice Bag",
	tiles = {"rice_bag_top.png", "rice_bag_bottom.png", "rice_bag_side.png",
		"rice_bag_side_tied.png", "rice_bag_side.png", "rice_bag_side.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
})
minetest.register_craft({
	output = "better_farming:rice_crate",
	recipe = {
		{"better_farming:rice", "better_farming:rice", "better_farming:rice"},
		{"better_farming:rice", "group:wood", "farming:string"},
		{"better_farming:rice", "better_farming:rice", "better_farming:rice"},
	}
})
]]--
