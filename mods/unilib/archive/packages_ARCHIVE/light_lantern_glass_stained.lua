---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    nbea
-- Code:    WTFPL
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("nbea:nbox_006", {
	description = "Stained Glass",
	inventory_image = "nbea_sglass.png",
	wield_image = "nbea_sglass.png",
	tiles = {"nbea_sglass.png"},
	drawtype = "nodebox",
	use_texture_alpha = true,
	paramtype = "light",
	light_source = 8,
	climbable = true,
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {oddly_breakable_by_hand=3, choppy = 3},
	sounds = default.node_sound_glass_defaults(),
	node_box = {
		type = "fixed",
		fixed = {
			{0.25, -0.5, -0.5, 0.3125, 0.5, 0.5},
			{-0.3125, -0.5, -0.5, -0.25, 0.5, 0.5},
			{-0.5, -0.5, -0.3125, 0.5, 0.5, -0.25},
			{-0.5, -0.5, 0.25, 0.5, 0.5, 0.3125},
			{-0.5, -0.3125, -0.5, 0.5, -0.25, 0.5},
			{-0.5, 0.25, -0.5, 0.5, 0.3125, 0.5},
			{-0.4375, -0.4375, -0.4375, 0.4375, 0.4375, 0.4375},
		-- corner frame
			{-0.4375, 0.4375, 0.4375, 0.4375, 0.5, 0.5},
			{-0.4375, -0.5, 0.4375, 0.4375, -0.4375, 0.5},
			{-0.5, -0.5, 0.4375, -0.4375, 0.5, 0.5},
			{0.4375, -0.5, 0.4375, 0.5, 0.5, 0.5},
			{-0.5, 0.4375, -0.4375, -0.4375, 0.5, 0.4375},
			{-0.5, -0.5, -0.4375, -0.4375, -0.4375, 0.4375},
			{0.4375, 0.4375, -0.4375, 0.5, 0.5, 0.4375},
			{0.4375, -0.5, -0.4375, 0.5, -0.4375, 0.4375},
			{-0.5, 0.4375, -0.5, 0.5, 0.5, -0.4375},
			{-0.5, -0.5, -0.5, 0.5, -0.4375, -0.4375},
			{0.4375, -0.4375, -0.5, 0.5, 0.4375, -0.4375},
			{-0.5, -0.4375, -0.5, -0.4375, 0.4375, -0.4375},
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
		},
	},
})
]]--