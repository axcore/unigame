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
minetest.register_node("nbea:nbox_014", {
	description = "Minetest Souvenir",
	tiles = {
		"nbea_mticon_top.png^nbea_frame_wood.png",          -- (Y+)
		"nbea_mticon_bottom.png^nbea_frame_wood.png",          -- (Y-)
		"nbea_mticon_right.png^nbea_frame_wood.png",          -- (X+)
		"nbea_mticon_left.png^nbea_frame_wood.png",          -- (X-)
		"nbea_mticon_back.png^nbea_frame_wood.png",          -- (Z+)
		"nbea_mticon_front.png^nbea_frame_wood.png"          -- (Z-)
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	is_ground_content = false,
    	drop = "",
	groups = {oddly_breakable_by_hand=3},
	sounds = default.node_sound_wood_defaults({
		footstep = {name = "default_glass_footstep", gain = 0.5},
		dug = {name = "default_break_glass", gain = 1.0},
	}),
	node_box = {
		type = "fixed",
		fixed = {
			{-0.4375, -0.4375, -0.4375, 0.0625, 0.0625, 0.0625},
			{-0.4375, -0.4375, 0.0625, -0.1875, 0.0625, 0.4375},
			{-0.1875, -0.4375, 0.0625, 0.4375, 0, 0.4375},
			{0.0625, -0.4375, -0.4375, 0.4375, -0.125, 0.0625},
			{-0.4375, 0.1875, -0.4375, -0.125, 0.4375, -0.125},
			{-0.3125, 0.0625, -0.3125, -0.25, 0.1875, -0.25},
			{0.25, 0, 0.25, 0.375, 0.3125, 0.375},
			{-0.5, -0.5, -0.5, 0.5, -0.4375, 0.5},
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
    after_destruct = function(pos,node)
			minetest.set_node(pos, {name= "nbea:nbox_013", param2=node.param2})
	end,
})

minetest.register_node("nbea:nbox_013", {
	description = "Minetest Model",
	tiles = {
		"nbea_mticon_top.png",          -- (Y+)
		"nbea_mticon_bottom.png",          -- (Y-)
		"nbea_mticon_right.png",          -- (X+)
		"nbea_mticon_left.png",          -- (X-)
		"nbea_mticon_back.png",          -- (Z+)
		"nbea_mticon_front.png"         -- (Z-)
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {oddly_breakable_by_hand = 3, falling_node = 1, not_in_creative_inventory = 1},
	sounds = default.node_sound_leaves_defaults(),
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.0625, 0.0625, 0.0625},
			{-0.5, -0.5, 0.0625, -0.1875, 0.0625, 0.5},
			{-0.1875, -0.5, 0.0625, 0.5, 0, 0.5},
			{0.0625, -0.5, -0.5, 0.5, -0.125, 0.0625},
			{-0.4375, 0.1875, -0.4375, -0.125, 0.4375, -0.125},
			{-0.3125, 0.0625, -0.3125, -0.25, 0.1875, -0.25},
			{0.25, 0, 0.25, 0.375, 0.3125, 0.375},
		},
	},
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, 0.4375, 0.5},
        },
    },
})
]]--
