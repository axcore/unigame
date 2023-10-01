---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    castle/castle_lighting
-- Code:    MIT
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node( "castle_lighting:chandelier", {
	drawtype = "plantlike",
	description = S("Chandelier"),
	paramtype = "light",
	wield_image = "castle_chandelier_wield.png",
	inventory_image = "castle_chandelier_wield.png", 
	groups = {cracky=2},
	sounds = default.node_sound_glass_defaults(),
	sunlight_propagates = true,
	light_source = 14,
	tiles = {
			{
			name = "castle_chandelier.png",
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 1.0
			},
		},
	},
	selection_box = {
		type = "fixed",
			fixed = {
				{0.35,-0.375,0.35,-0.35,0.5,-0.35},

		},
	},
})
minetest.register_craft({
	output = "castle_lighting:chandelier",
	recipe = {
		{"", "", ""},
		{"", "default:steel_ingot", ""},
		{"default:torch","default:torch","default:torch"},
	}
})

minetest.register_node( "castle_lighting:chandelier_chain", {
	drawtype = "plantlike",
	description = S("Chandelier Chain"),
	paramtype = "light",
	wield_image = "castle_chandelier_chain.png",
	inventory_image = "castle_chandelier_chain.png", 
	groups = {cracky=2},
	sounds = default.node_sound_glass_defaults(),
	sunlight_propagates = true,
	tiles = {"castle_chandelier_chain.png"},
	selection_box = {
		type = "fixed",
			fixed = {
				{0.1,-0.5,0.1,-0.1,0.5,-0.1},

		},
	},
})
minetest.register_craft({
	output = "castle_lighting:chandelier_chain 4",
	recipe = {
		{"", "default:steel_ingot", ""},
		{"", "", ""},
		{"","default:steel_ingot",""},
	}
})
]]--
