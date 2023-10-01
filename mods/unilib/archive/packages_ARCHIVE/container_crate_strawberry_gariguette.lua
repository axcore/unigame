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
minetest.register_node("better_farming:strawberry_crate", {
	description = "Strawberry Bag",
	tiles = {"strawberry_crate_top.png", "strawberry_crate_bottom.png", "strawberry_crate_side.png",
		"strawberry_crate_side.png", "strawberry_crate_side.png", "strawberry_crate_side.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
    sounds = default.node_sound_wood_defaults(),
})
minetest.register_craft({
	output = "better_farming:strawberry_crate",
	recipe = {
		{"better_farming:strawberry", "better_farming:strawberry", "better_farming:strawberry"},
		{"better_farming:strawberry", "group:wood", "farming:string"},
		{"better_farming:strawberry", "better_farming:strawberry", "better_farming:strawberry"},
	}
})
]]--
