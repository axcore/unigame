---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xdecor
-- Code:    BSD
-- Media:   WTFPL/CC BY-SA/CC BY 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
xdecor.register("woodframed_glass", {
	description = S("Wood Framed Glass"),
	drawtype = "glasslike_framed",
	sunlight_propagates = true,
	tiles = {"xdecor_woodframed_glass.png", "xdecor_woodframed_glass_detail.png"},
	use_texture_alpha = ALPHA_CLIP,
	groups = {cracky = 2, oddly_breakable_by_hand = 1},
	sounds = default.node_sound_glass_defaults()
})
minetest.register_craft({
	output = "xdecor:woodframed_glass",
	recipe = {
		{"group:stick", "group:stick", "group:stick"},
		{"group:stick", "default:glass", "group:stick"},
		{"group:stick", "group:stick", "group:stick"}
	}
})
]]--
