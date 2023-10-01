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
minetest.register_node("better_farming:mint_crate", {
	description = "Mint Crate",
	tiles = {"mint_crate_top.png", "crate_bottom.png", "mint_crate_side.png",
		"mint_crate_side.png", "mint_crate_side.png", "mint_crate_side.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
})
minetest.register_craft({
	output = "better_farming:mint_crate",
	recipe = {
		{"better_farming:mint", "better_farming:mint", "better_farming:mint"},
		{"better_farming:mint", "group:wood", "better_farming:mint"},
		{"better_farming:mint", "better_farming:mint", "better_farming:mint"},
	}
})
]]--
