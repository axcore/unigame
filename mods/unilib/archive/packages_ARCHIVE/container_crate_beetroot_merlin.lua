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
minetest.register_node("better_farming:beetroot_crate", {
	description = "Beetroot Crate",
	tiles = {"beetroot_crate_top.png", "crate_bottom.png", "beetroot_crate_side.png",
		"beetroot_crate_side.png", "beetroot_crate_side.png", "beetroot_crate_side.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
})
minetest.register_craft({
	output = "better_farming:beetroot_crate",
	recipe = {
		{"better_farming:beetroot", "better_farming:beetroot", "better_farming:beetroot"},
		{"better_farming:beetroot", "group:wood", "better_farming:beetroot"},
		{"better_farming:beetroot", "better_farming:beetroot", "better_farming:beetroot"},
	}
})
]]--
