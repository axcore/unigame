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
minetest.register_node("better_farming:kale_crate", {
	description = "Kale Bag",
	tiles = {"kale_crate_top.png", "crate_bottom.png", "rice_bag_side.png",
		"rice_bag_side.png", "rice_bag_side.png", "rice_bag_side.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
})
minetest.register_craft({
	output = "better_farming:kale_crate",
	recipe = {
		{"better_farming:kale", "better_farming:kale", "better_farming:kale"},
		{"better_farming:kale", "group:wood", "farming:string"},
		{"better_farming:kale", "better_farming:kale", "better_farming:kale"},
	}
})
]]--
