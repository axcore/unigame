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
minetest.register_node("nbea:nbox_012", {
	description = "Mese Companion",
    	tiles = {"nbea_mese_companion.png"},
	drawtype = "nodebox",
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {oddly_breakable_by_hand=3, cracky = 3},
	sounds = default.node_sound_metal_defaults(),
	node_box = {
		type = "fixed",
		fixed = {
			{0.1875, -0.4375, -0.4375, 0.4375, -0.125, -0.375},
			{-0.4375, -0.4375, -0.4375, -0.1875, -0.125, -0.375},
			{0.125, 0.1875, -0.4375, 0.4375, 0.4375, -0.375},
			{-0.4375, 0.1875, -0.4375, -0.125, 0.4375, -0.375},
			{0.25, -0.375, -0.5, 0.4375, -0.125, -0.4375},
			{0.125, -0.4375, -0.5, 0.375, -0.25, -0.4375},
			{0.1875, -0.375, -0.5, 0.375, -0.1875, -0.4375},
			{0.125, -0.4375, -0.4375, 0.4375, -0.1875, -0.375},
			{-0.4375, -0.4375, -0.4375, -0.125, -0.1875, -0.375},
			{-0.4375, -0.375, -0.5, -0.25, -0.125, -0.4375},
			{-0.375, -0.4375, -0.5, -0.125, -0.25, -0.4375},
			{-0.375, -0.375, -0.5, -0.1875, -0.1875, -0.4375},
			{0.1875, 0.125, -0.4375, 0.4375, 0.4375, -0.375},
			{-0.4375, 0.125, -0.4375, -0.1875, 0.4375, -0.375},
			{0.1875, 0.1875, -0.5, 0.375, 0.375, -0.4375},
			{0.25, 0.125, -0.5, 0.4375, 0.375, -0.4375},
			{0.125, 0.25, -0.5, 0.375, 0.4375, -0.4375},
			{-0.4375, 0.125, -0.5, -0.25, 0.375, -0.4375},
			{-0.375, 0.25, -0.5, -0.125, 0.4375, -0.4375},
			{-0.375, 0.1875, -0.5, -0.1875, 0.375, -0.4375},
			{-0.125, 0.25, -0.4375, 0.125, 0.375, -0.3125},
			{-0.125, -0.375, -0.4375, 0.125, -0.25, -0.3125},
			{0.25, -0.125, -0.4375, 0.375, 0.125, -0.3125},
			{-0.375, -0.125, -0.4375, -0.25, 0.125, -0.3125},
			{-0.125, -0.125, -0.4375, -0.0625, 0.125, -0.375},
			{0.0625, -0.125, -0.4375, 0.125, 0.125, -0.375},
			{-0.0625, -0.125, -0.4375, 0.0625, -0.0625, -0.375},
			{-0.0625, 0.0625, -0.4375, 0.0625, 0.125, -0.375},
			{-0.4375, -0.4375, -0.4375, -0.375, -0.125, -0.1875},
			{-0.4375, -0.4375, 0.1875, -0.375, -0.125, 0.4375},
			{-0.4375, 0.1875, -0.4375, -0.375, 0.4375, -0.125},
			{-0.4375, 0.1875, 0.125, -0.375, 0.4375, 0.4375},
			{-0.5, -0.375, -0.4375, -0.4375, -0.125, -0.25},
			{-0.5, -0.4375, -0.375, -0.4375, -0.25, -0.125},
			{-0.5, -0.375, -0.375, -0.4375, -0.1875, -0.1875},
			{-0.4375, -0.4375, -0.4375, -0.375, -0.1875, -0.125},
			{-0.4375, -0.4375, 0.125, -0.375, -0.1875, 0.4375},
			{-0.5, -0.375, 0.25, -0.4375, -0.125, 0.4375},
			{-0.5, -0.4375, 0.125, -0.4375, -0.25, 0.375},
			{-0.5, -0.375, 0.1875, -0.4375, -0.1875, 0.375},
			{-0.4375, 0.125, -0.4375, -0.375, 0.4375, -0.1875},
			{-0.4375, 0.125, 0.1875, -0.375, 0.4375, 0.4375},
			{-0.5, 0.1875, -0.375, -0.4375, 0.375, -0.1875},
			{-0.5, 0.125, -0.4375, -0.4375, 0.375, -0.25},
			{-0.5, 0.25, -0.375, -0.4375, 0.4375, -0.125},
			{-0.5, 0.125, 0.25, -0.4375, 0.375, 0.4375},
			{-0.5, 0.25, 0.125, -0.4375, 0.4375, 0.375},
			{-0.5, 0.1875, 0.1875, -0.4375, 0.375, 0.375},
			{-0.4375, 0.25, -0.125, -0.3125, 0.375, 0.125},
			{-0.4375, -0.375, -0.125, -0.3125, -0.25, 0.125},
			{-0.4375, -0.125, -0.375, -0.3125, 0.125, -0.25},
			{-0.4375, -0.125, 0.25, -0.3125, 0.125, 0.375},
			{-0.4375, -0.125, 0.0625, -0.375, 0.125, 0.125},
			{-0.4375, -0.125, -0.125, -0.375, 0.125, -0.0625},
			{-0.4375, -0.125, -0.0625, -0.375, -0.0625, 0.0625},
			{-0.4375, 0.0625, -0.0625, -0.375, 0.125, 0.0625},
            		{0.375, -0.4375, 0.1875, 0.4375, -0.125, 0.4375},
			{0.375, -0.4375, -0.4375, 0.4375, -0.125, -0.1875},
			{0.375, 0.1875, 0.125, 0.4375, 0.4375, 0.4375},
			{0.375, 0.1875, -0.4375, 0.4375, 0.4375, -0.125},
			{0.4375, -0.375, 0.25, 0.5, -0.125, 0.4375},
			{0.4375, -0.4375, 0.125, 0.5, -0.25, 0.375},
			{0.4375, -0.375, 0.1875, 0.5, -0.1875, 0.375},
			{0.375, -0.4375, 0.125, 0.4375, -0.1875, 0.4375},
			{0.375, -0.4375, -0.4375, 0.4375, -0.1875, -0.125},
			{0.4375, -0.375, -0.4375, 0.5, -0.125, -0.25},
			{0.4375, -0.4375, -0.375, 0.5, -0.25, -0.125},
			{0.4375, -0.375, -0.375, 0.5, -0.1875, -0.1875},
			{0.375, 0.125, 0.1875, 0.4375, 0.4375, 0.4375},
			{0.375, 0.125, -0.4375, 0.4375, 0.4375, -0.1875},
			{0.4375, 0.1875, 0.1875, 0.5, 0.375, 0.375},
			{0.4375, 0.125, 0.25, 0.5, 0.375, 0.4375},
			{0.4375, 0.25, 0.125, 0.5, 0.4375, 0.375},
			{0.4375, 0.125, -0.4375, 0.5, 0.375, -0.25},
			{0.4375, 0.25, -0.375, 0.5, 0.4375, -0.125},
			{0.4375, 0.1875, -0.375, 0.5, 0.375, -0.1875},
			{0.3125, 0.25, -0.125, 0.4375, 0.375, 0.125},
			{0.3125, -0.375, -0.125, 0.4375, -0.25, 0.125},
			{0.3125, -0.125, 0.25, 0.4375, 0.125, 0.375},
			{0.3125, -0.125, -0.375, 0.4375, 0.125, -0.25},
			{0.375, -0.125, -0.125, 0.4375, 0.125, -0.0625},
			{0.375, -0.125, 0.0625, 0.4375, 0.125, 0.125},
			{0.375, -0.125, -0.0625, 0.4375, -0.0625, 0.0625},
			{0.375, 0.0625, -0.0625, 0.4375, 0.125, 0.0625},
			{0.125, 0.375, 0.1875, 0.4375, 0.4375, 0.4375},
			{0.125, 0.375, -0.4375, 0.4375, 0.4375, -0.1875},
			{-0.4375, 0.375, 0.125, -0.1875, 0.4375, 0.4375},
			{-0.4375, 0.375, -0.4375, -0.1875, 0.4375, -0.125},
			{0.125, 0.4375, 0.25, 0.375, 0.5, 0.4375},
			{0.25, 0.4375, 0.125, 0.4375, 0.5, 0.375},
			{0.1875, 0.4375, 0.1875, 0.375, 0.5, 0.375},
			{0.1875, 0.375, 0.125, 0.4375, 0.4375, 0.4375},
			{0.1875, 0.375, -0.4375, 0.4375, 0.4375, -0.125},
			{0.125, 0.4375, -0.4375, 0.375, 0.5, -0.25},
			{0.25, 0.4375, -0.375, 0.4375, 0.5, -0.125},
			{0.1875, 0.4375, -0.375, 0.375, 0.5, -0.1875},
			{-0.4375, 0.375, 0.1875, -0.125, 0.4375, 0.4375},
			{-0.4375, 0.375, -0.4375, -0.125, 0.4375, -0.1875},
			{-0.375, 0.4375, 0.1875, -0.1875, 0.5, 0.375},
			{-0.375, 0.4375, 0.25, -0.125, 0.5, 0.4375},
			{-0.4375, 0.4375, 0.125, -0.25, 0.5, 0.375},
			{-0.375, 0.4375, -0.4375, -0.125, 0.5, -0.25},
			{-0.4375, 0.4375, -0.375, -0.25, 0.5, -0.125},
			{-0.375, 0.4375, -0.375, -0.1875, 0.5, -0.1875},
			{-0.375, 0.3125, -0.125, -0.25, 0.4375, 0.125},
			{0.25, 0.3125, -0.125, 0.375, 0.4375, 0.125},
			{-0.125, 0.3125, 0.25, 0.125, 0.4375, 0.375},
			{-0.125, 0.3125, -0.375, 0.125, 0.4375, -0.25},
			{-0.125, 0.375, -0.125, 0.125, 0.4375, -0.0625},
			{-0.125, 0.375, 0.0625, 0.125, 0.4375, 0.125},
			{0.0625, 0.375, -0.0625, 0.125, 0.4375, 0.0625},
			{-0.125, 0.375, -0.0625, -0.0625, 0.4375, 0.0625},
			{-0.375, -0.375, -0.375, 0.375, 0.375, 0.375},
			{-0.4375, -0.4375, 0.375, -0.1875, -0.125, 0.4375},
			{0.1875, -0.4375, 0.375, 0.4375, -0.125, 0.4375},
			{-0.4375, 0.1875, 0.375, -0.125, 0.4375, 0.4375},
			{0.125, 0.1875, 0.375, 0.4375, 0.4375, 0.4375},
			{-0.4375, -0.375, 0.4375, -0.25, -0.125, 0.5},
			{-0.375, -0.4375, 0.4375, -0.125, -0.25, 0.5},
			{-0.375, -0.375, 0.4375, -0.1875, -0.1875, 0.5},
			{-0.4375, -0.4375, 0.375, -0.125, -0.1875, 0.4375},
			{0.125, -0.4375, 0.375, 0.4375, -0.1875, 0.4375},
			{0.25, -0.375, 0.4375, 0.4375, -0.125, 0.5},
			{0.125, -0.4375, 0.4375, 0.375, -0.25, 0.5},
			{0.1875, -0.375, 0.4375, 0.375, -0.1875, 0.5},
			{-0.4375, 0.125, 0.375, -0.1875, 0.4375, 0.4375},
			{0.1875, 0.125, 0.375, 0.4375, 0.4375, 0.4375},
			{-0.375, 0.1875, 0.4375, -0.1875, 0.375, 0.5},
			{-0.4375, 0.125, 0.4375, -0.25, 0.375, 0.5},
			{-0.375, 0.25, 0.4375, -0.125, 0.4375, 0.5},
			{0.25, 0.125, 0.4375, 0.4375, 0.375, 0.5},
			{0.125, 0.25, 0.4375, 0.375, 0.4375, 0.5},
			{0.1875, 0.1875, 0.4375, 0.375, 0.375, 0.5},
			{-0.125, 0.25, 0.3125, 0.125, 0.375, 0.4375},
			{-0.125, -0.375, 0.3125, 0.125, -0.25, 0.4375},
			{-0.375, -0.125, 0.3125, -0.25, 0.125, 0.4375},
			{0.25, -0.125, 0.3125, 0.375, 0.125, 0.4375},
			{0.0625, -0.125, 0.375, 0.125, 0.125, 0.4375},
			{-0.125, -0.125, 0.375, -0.0625, 0.125, 0.4375},
			{-0.0625, -0.125, 0.375, 0.0625, -0.0625, 0.4375},
			{-0.0625, 0.0625, 0.375, 0.0625, 0.125, 0.4375},
			{-0.4375, -0.4375, -0.4375, -0.1875, -0.375, -0.125},
			{0.1875, -0.4375, -0.4375, 0.4375, -0.375, -0.125},
			{-0.4375, -0.4375, 0.1875, -0.125, -0.375, 0.4375},
			{0.125, -0.4375, 0.1875, 0.4375, -0.375, 0.4375},
			{-0.4375, -0.5, -0.375, -0.25, -0.4375, -0.125},
			{-0.375, -0.5, -0.4375, -0.125, -0.4375, -0.25},
			{-0.375, -0.5, -0.375, -0.1875, -0.4375, -0.1875},
			{-0.4375, -0.4375, -0.4375, -0.125, -0.375, -0.1875},
			{0.125, -0.4375, -0.4375, 0.4375, -0.375, -0.1875},
			{0.25, -0.5, -0.375, 0.4375, -0.4375, -0.125},
			{0.125, -0.5, -0.4375, 0.375, -0.4375, -0.25},
			{0.1875, -0.5, -0.375, 0.375, -0.4375, -0.1875},
			{-0.4375, -0.4375, 0.125, -0.1875, -0.375, 0.4375},
			{0.1875, -0.4375, 0.125, 0.4375, -0.375, 0.4375},
			{-0.375, -0.5, 0.1875, -0.1875, -0.4375, 0.375},
			{-0.4375, -0.5, 0.125, -0.25, -0.4375, 0.375},
			{-0.375, -0.5, 0.25, -0.125, -0.4375, 0.4375},
			{0.25, -0.5, 0.125, 0.4375, -0.4375, 0.375},
			{0.125, -0.5, 0.25, 0.375, -0.4375, 0.4375},
			{0.1875, -0.5, 0.1875, 0.375, -0.4375, 0.375},
			{-0.125, -0.4375, 0.25, 0.125, -0.3125, 0.375},
			{-0.125, -0.4375, -0.375, 0.125, -0.3125, -0.25},
			{-0.375, -0.4375, -0.125, -0.25, -0.3125, 0.125},
			{0.25, -0.4375, -0.125, 0.375, -0.3125, 0.125},
			{0.0625, -0.4375, -0.125, 0.125, -0.375, 0.125},
			{-0.125, -0.4375, -0.125, -0.0625, -0.375, 0.125},
			{-0.0625, -0.4375, -0.125, 0.0625, -0.375, -0.0625},
			{-0.0625, -0.4375, 0.0625, 0.0625, -0.375, 0.125},
		},
	},
    selection_box = {
        type = "fixed",
        fixed = {
			{-0.4375, -0.4375, -0.4375, 0.4375, 0.4375, 0.4375},
        },
    },
})
]]--
