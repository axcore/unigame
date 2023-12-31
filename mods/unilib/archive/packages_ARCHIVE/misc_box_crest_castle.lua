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
minetest.register_node("nbea:nbox_011", {
	description = "Castle Crest",
	inventory_image = "nbea_crest.png",
    	wield_image = "nbea_crest.png",
    	tiles = {"nbea_crest.png"},
	drawtype = "nodebox",
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {cracky = 3, choppy = 2},
	sounds = default.node_sound_stone_defaults(),
	node_box = {
		type = "fixed",
		fixed = {
			-- top  (Y+)
			{-0.0625, 0.4375, -0.25, 0.0625, 0.5, 0.25},
			{-0.25, 0.4375, -0.0625, 0.25, 0.5, 0.0625},
			{-0.125, 0.4375, 0.125, 0.125, 0.5, 0.1875},
			{-0.125, 0.4375, -0.1875, 0.125, 0.5, -0.125},
			{0.125, 0.4375, -0.125, 0.1875, 0.5, 0.125},
			{-0.1875, 0.4375, -0.125, -0.125, 0.5, 0.125},
			{-0.3125, 0.4375, 0.0625, -0.25, 0.5, 0.3125},
			{-0.3125, 0.4375, -0.3125, -0.25, 0.5, -0.0625},
			{0.25, 0.4375, 0.0625, 0.3125, 0.5, 0.3125},
			{0.25, 0.4375, -0.3125, 0.3125, 0.5, -0.0625},
			{0.0625, 0.4375, 0.25, 0.3125, 0.5, 0.3125},
			{-0.3125, 0.4375, 0.25, -0.0625, 0.5, 0.3125},
			{0.0625, 0.4375, -0.3125, 0.25, 0.5, -0.25},
			{-0.3125, 0.4375, -0.3125, -0.0625, 0.5, -0.25},
			{0.375, 0.4375, 0.375, 0.4375, 0.5, 0.4375},
			{-0.4375, 0.4375, 0.375, -0.375, 0.5, 0.4375},
			{0.375, 0.4375, -0.4375, 0.4375, 0.5, -0.375},
			{-0.4375, 0.4375, -0.4375, -0.375, 0.5, -0.375},
			-- bottom  (Y-)
			{-0.0625, -0.5, -0.25, 0.0625, -0.4375, 0.25},
			{-0.25, -0.5, -0.0625, 0.25, -0.4375, 0.0625},
			{-0.125, -0.5, 0.125, 0.125, -0.4375, 0.1875},
			{-0.125, -0.5, -0.1875, 0.125, -0.4375, -0.125},
			{-0.1875, -0.5, -0.125, -0.125, -0.4375, 0.125},
			{0.125, -0.5, -0.125, 0.1875, -0.4375, 0.125},
			{0.25, -0.5, 0.0625, 0.3125, -0.4375, 0.3125},
			{0.25, -0.5, -0.3125, 0.3125, -0.4375, -0.0625},
			{-0.3125, -0.5, 0.0625, -0.25, -0.4375, 0.3125},
			{-0.3125, -0.5, -0.3125, -0.25, -0.4375, -0.0625},
			{-0.3125, -0.5, 0.25, -0.0625, -0.4375, 0.3125},
			{0.0625, -0.5, 0.25, 0.3125, -0.4375, 0.3125},
			{-0.25, -0.5, -0.3125, -0.0625, -0.4375, -0.25},
			{0.0625, -0.5, -0.3125, 0.3125, -0.4375, -0.25},
			{-0.4375, -0.5, 0.375, -0.375, -0.4375, 0.4375},
			{0.375, -0.5, 0.375, 0.4375, -0.4375, 0.4375},
			{-0.4375, -0.5, -0.4375, -0.375, -0.4375, -0.375},
			{0.375, -0.5, -0.4375, 0.4375, -0.4375, -0.375},
			-- right  (X+)
			{0.4375, -0.0625, -0.25, 0.5, 0.0625, 0.25},
			{0.4375, -0.25, -0.0625, 0.5, 0.25, 0.0625},
			{0.4375, -0.125, 0.125, 0.5, 0.125, 0.1875},
			{0.4375, -0.125, -0.1875, 0.5, 0.125, -0.125},
			{0.4375, -0.1875, -0.125, 0.5, -0.125, 0.125},
			{0.4375, 0.125, -0.125, 0.5, 0.1875, 0.125},
			{0.4375, 0.25, 0.0625, 0.5, 0.3125, 0.3125},
			{0.4375, 0.25, -0.3125, 0.5, 0.3125, -0.0625},
			{0.4375, -0.3125, 0.0625, 0.5, -0.25, 0.3125},
			{0.4375, -0.3125, -0.3125, 0.5, -0.25, -0.0625},
			{0.4375, -0.3125, 0.25, 0.5, -0.0625, 0.3125},
			{0.4375, 0.0625, 0.25, 0.5, 0.3125, 0.3125},
			{0.4375, -0.25, -0.3125, 0.5, -0.0625, -0.25},
			{0.4375, 0.0625, -0.3125, 0.5, 0.3125, -0.25},
			{0.4375, -0.4375, 0.375, 0.5, -0.375, 0.4375},
			{0.4375, 0.375, 0.375, 0.5, 0.4375, 0.4375},
			{0.4375, -0.4375, -0.4375, 0.5, -0.375, -0.375},
			{0.4375, 0.375, -0.4375, 0.5, 0.4375, -0.375},
			-- left  (X-)
			{-0.5, -0.0625, -0.25, -0.4375, 0.0625, 0.25},
			{-0.5, -0.25, -0.0625, -0.4375, 0.25, 0.0625},
			{-0.5, -0.125, -0.1875, -0.4375, 0.125, -0.125},
			{-0.5, -0.125, 0.125, -0.4375, 0.125, 0.1875},
			{-0.5, -0.1875, -0.125, -0.4375, -0.125, 0.125},
			{-0.5, 0.125, -0.125, -0.4375, 0.1875, 0.125},
			{-0.5, 0.25, -0.3125, -0.4375, 0.3125, -0.0625},
			{-0.5, 0.25, 0.0625, -0.4375, 0.3125, 0.3125},
			{-0.5, -0.3125, -0.3125, -0.4375, -0.25, -0.0625},
			{-0.5, -0.3125, 0.0625, -0.4375, -0.25, 0.3125},
			{-0.5, -0.3125, -0.3125, -0.4375, -0.0625, -0.25},
			{-0.5, 0.0625, -0.3125, -0.4375, 0.3125, -0.25},
			{-0.5, -0.25, 0.25, -0.4375, -0.0625, 0.3125},
			{-0.5, 0.0625, 0.25, -0.4375, 0.3125, 0.3125},
			{-0.5, -0.4375, -0.4375, -0.4375, -0.375, -0.375},
			{-0.5, 0.375, -0.4375, -0.4375, 0.4375, -0.375},
			{-0.5, -0.4375, 0.375, -0.4375, -0.375, 0.4375},
			{-0.5, 0.375, 0.375, -0.4375, 0.4375, 0.4375},
			-- back  (Z+)
			{-0.25, -0.0625, 0.4375, 0.25, 0.0625, 0.5},
			{-0.0625, -0.25, 0.4375, 0.0625, 0.25, 0.5},
			{-0.1875, -0.125, 0.4375, -0.125, 0.125, 0.5},
			{0.125, -0.125, 0.4375, 0.1875, 0.125, 0.5},
			{-0.125, -0.1875, 0.4375, 0.125, -0.125, 0.5},
			{-0.125, 0.125, 0.4375, 0.125, 0.1875, 0.5},
			{-0.3125, 0.25, 0.4375, -0.0625, 0.3125, 0.5},
			{0.0625, 0.25, 0.4375, 0.3125, 0.3125, 0.5},
			{-0.3125, -0.3125, 0.4375, -0.0625, -0.25, 0.5},
			{0.0625, -0.3125, 0.4375, 0.3125, -0.25, 0.5},
			{-0.3125, -0.3125, 0.4375, -0.25, -0.0625, 0.5},
			{-0.3125, 0.0625, 0.4375, -0.25, 0.3125, 0.5},
			{0.25, -0.25, 0.4375, 0.3125, -0.0625, 0.5},
			{0.25, 0.0625, 0.4375, 0.3125, 0.3125, 0.5},
			{-0.4375, -0.4375, 0.4375, -0.375, -0.375, 0.5},
			{-0.4375, 0.375, 0.4375, -0.375, 0.4375, 0.5},
			{0.375, -0.4375, 0.4375, 0.4375, -0.375, 0.5},
			{0.375, 0.375, 0.4375, 0.4375, 0.4375, 0.5},
			-- front  (Z-)
			{-0.25, -0.0625, -0.5, 0.25, 0.0625, -0.4375},
			{-0.0625, -0.25, -0.5, 0.0625, 0.25, -0.4375},
			{0.125, -0.125, -0.5, 0.1875, 0.125, -0.4375},
			{-0.1875, -0.125, -0.5, -0.125, 0.125, -0.4375},
			{-0.125, -0.1875, -0.5, 0.125, -0.125, -0.4375},
			{-0.125, 0.125, -0.5, 0.125, 0.1875, -0.4375},
			{0.0625, 0.25, -0.5, 0.3125, 0.3125, -0.4375},
			{-0.3125, 0.25, -0.5, -0.0625, 0.3125, -0.4375},
			{0.0625, -0.3125, -0.5, 0.3125, -0.25, -0.4375},
			{-0.3125, -0.3125, -0.5, -0.0625, -0.25, -0.4375},
			{0.25, -0.3125, -0.5, 0.3125, -0.0625, -0.4375},
			{0.25, 0.0625, -0.5, 0.3125, 0.3125, -0.4375},
			{-0.3125, -0.25, -0.5, -0.25, -0.0625, -0.4375},
			{-0.3125, 0.0625, -0.5, -0.25, 0.3125, -0.4375},
			{0.375, -0.4375, -0.5, 0.4375, -0.375, -0.4375},
			{0.375, 0.375, -0.5, 0.4375, 0.4375, -0.4375},
			{-0.4375, -0.4375, -0.5, -0.375, -0.375, -0.4375},
			{-0.4375, 0.375, -0.5, -0.375, 0.4375, -0.4375},
			-- center mass  14px
			{-0.48, -0.48, -0.48, 0.48, 0.48, 0.48},
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
