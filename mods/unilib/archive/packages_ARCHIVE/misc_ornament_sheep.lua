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
minetest.register_node("nbea:nbox_010", {
	description = "Little Sheep",
	tiles = {
		"nbea_sheep_top.png", -- (Y+)
		"nbea_sheep_bottom.png", -- (Y-)
		"nbea_sheep_right_side.png", -- (X+)
		"nbea_sheep_left_side.png", -- (X-)
		"nbea_sheep_back.png", -- (Z+)
		"nbea_sheep_front.png" -- (Z-)
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {oddly_breakable_by_hand=3, dig_immediate=3, bouncy=100},
	sounds = default.node_sound_leaves_defaults({
		place = {name = "nbea_sheep", gain = 0.25},
		footstep = {name = "nbea_bounce", gain = 0.25},
		dig = {name = "nbea_bounce", gain = 0.25},
		dug = {name = "nbea_sheep_hurt", gain = 0.25},
	}),
	node_box = {
		type = "fixed",
		fixed = {
			{-0.3125, -0.375, -0.1875, 0.3125, 0.1875, 0.4375},
			{-0.1875, -0.25, -0.375, 0.1875, 0.0625, -0.125},
			{-0.25, -0.0625, -0.3125, 0.25, 0.06, -0.1875},
			{-0.125, -0.3125, -0.5, 0.125, 0.08995, -0.3125},
			{-0.25, -0.5, -0.125, -0.0625, -0.375, 0.0625},
			{0.0625, -0.5, -0.125, 0.25, -0.3125, 0.0625},
			{-0.25, -0.5, 0.1875, -0.0625, -0.3125, 0.375},
			{0.0625, -0.5, 0.1875, 0.25, -0.3125, 0.375},
			{-0.0625, -0.1875, 0.4375, 0.0625, 0.0625, 0.5},
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
