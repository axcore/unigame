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
minetest.register_node("ethereal:vine", {
	description = S("Vine"),
	drawtype = "signlike",
	tiles = {"ethereal_vine.png"},
	inventory_image = "ethereal_vine.png",
	wield_image = "ethereal_vine.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	walkable = false,
	climbable = true,
	is_ground_content = false,
	selection_box = {
		type = "wallmounted"
	},
	groups = {choppy = 3, oddly_breakable_by_hand = 1, flammable = 2},
	legacy_wallmounted = true,
	sounds = default.node_sound_leaves_defaults()
})
minetest.register_craft({
	output = "ethereal:vine 2",
	recipe = {
		{"group:leaves", "", "group:leaves"},
		{"", "group:leaves", ""},
		{"group:leaves", "", "group:leaves"}
	}
})
]]--
