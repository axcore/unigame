---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("ethereal:stone_ladder", {
	description = S("Stone Ladder"),
	drawtype = "signlike",
	tiles = {"ethereal_stone_ladder.png"},
	inventory_image = "ethereal_stone_ladder.png",
	wield_image = "ethereal_stone_ladder.png",
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "wallmounted",
	walkable = false,
	climbable = true,
	is_ground_content = false,
	selection_box = {
		type = "wallmounted"
	},
	groups = {cracky = 3, oddly_breakable_by_hand = 1},
	legacy_wallmounted = true,
	sounds = default.node_sound_stone_defaults()
})
minetest.register_craft({
	output = "ethereal:stone_ladder 4",
	recipe = {
		{"group:stone", "", "group:stone"},
		{"group:stone", "group:stone", "group:stone"},
		{"group:stone", "", "group:stone"}
	}
})
]]--
