---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    columnia
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("columnia:lamp_ceiling", {
    description = "Ceiling Lamp (Column)",
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	inventory_image = "columnia_lamp_inv.png",
	tiles = {
	         "columnia_rusty.png", "columnia_lamp.png", "columnia_lamp.png",
		     "columnia_lamp.png", "columnia_lamp.png", "columnia_lamp.png"
	        },
	sunlight_propagates = true,
	light_source = 13,
	walkable = false,
	groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.1875, 0.4375, -0.1875, 0.1875, 0.5, 0.1875},
			{-0.125, 0.375, -0.125, 0.125, 0.4375, 0.125}, 
		},
	},
	sounds = default.node_sound_glass_defaults(),
})
minetest.register_craft({
		output = 'columnia:lamp_ceiling 4',
		recipe = {
			{"columnia:blueprint", "default:steel_ingot", ""},
			{"", "default:torch", ""},
			{"", "default:glass", ""},
		},
		replacements = {{"columnia:blueprint", "columnia:blueprint"}},
})
]]--
