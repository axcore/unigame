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
minetest.register_node("ethereal:lightstring", {
	description = S("Light String Vine"),
	drawtype = "signlike",
	tiles = {"ethereal_lightstring.png"},
	inventory_image = "ethereal_lightstring.png",
	wield_image = "ethereal_lightstring.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	light_source = 10,
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
	output = "ethereal:lightstring 8",
	recipe = {
		{"ethereal:vine", "ethereal:vine", "ethereal:vine"},
		{"ethereal:vine", "ethereal:fire_dust", "ethereal:vine"},
		{"ethereal:vine", "ethereal:vine", "ethereal:vine"}
	}
})
]]--
