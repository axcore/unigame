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
minetest.register_node("nbea:nbox_002", {
	description = "Steel Framed Glass",
	inventory_image = "default_glass.png^nbea_steel.png",
	wield_image = "default_glass.png^nbea_steel.png",
	tiles = {"nbea_steel.png"},
	use_texture_alpha = true,
	drawtype = "nodebox",
	paramtype = "light",
	sunlight_propagates = true,
	climbable = true,
	is_ground_content = false,
	groups = {cracky = 3},
	sounds = default.node_sound_metal_defaults({
		footstep = {name = "default_glass_footstep", gain = 0.5},
		dug = {name = "default_break_glass", gain = 1.0},
	}),
	node_box = {
		type = "fixed",
		fixed = {
			{0.375, -0.5, -0.5, 0.4375, 0.5, 0.5},
			{-0.4375, -0.5, -0.5, -0.375, 0.5, 0.5},
			{0.25, -0.5, -0.5, 0.3125, 0.5, 0.5},
			{-0.3125, -0.5, -0.5, -0.25, 0.5, 0.5},
			{-0.5, -0.4375, -0.5, 0.5, -0.375, 0.5},
			{-0.5, -0.3125, -0.5, 0.5, -0.25, 0.5},
			{-0.5, 0.375, -0.5, 0.5, 0.4375, 0.5},
			{-0.5, 0.25, -0.5, 0.5, 0.3125, 0.5},
			{-0.5, -0.5, 0.375, 0.5, 0.5, 0.4375},
			{-0.5, -0.5, 0.25, 0.5, 0.5, 0.3125},
			{-0.5, -0.5, -0.4375, 0.5, 0.5, -0.375},
			{-0.5, -0.5, -0.3125, 0.5, 0.5, -0.25},
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
			-- center mass
			{-0.4375, -0.4375, -0.4375, 0.4375, 0.4375, 0.4375},
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