---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("flowers_plus:blue_ground_flower", {
	description = "Blue Ground Flower",
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = {
		"flowers_blue_ground_flower.png",
	},
	use_texture_alpha = "clip",
	node_box = {
		type = "fixed",
		fixed = {
		{-0.5,-0.5,-0.5,0.5,-0.49,0.5}
		}
	},
	buildable_to = true,
	groups = {snappy = 3, flammable = 1, dig_immediate = 1, flower = 1},
	sounds = default.node_sound_leaves_defaults()
})

minetest.register_node("flowers_plus:pink_ground_flower", {
	description = "Pink Ground flower",
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = {
		"flowers_pink_ground_flower.png",
	},
	use_texture_alpha = "clip",
	node_box = {
		type = "fixed",
		fixed = {
		{-0.5,-0.5,-0.5,0.5,-0.49,0.5}
		}
	},
	buildable_to = true,
	groups = {snappy = 3, flammable = 1, dig_immediate = 1, flower = 1},
	sounds = default.node_sound_leaves_defaults()
})

minetest.register_node("flowers_plus:red_ground_flower", {
	description = "Red Ground flower",
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = {
		"flowers_red_ground_flower.png",
	},
	use_texture_alpha = "clip",
	node_box = {
		type = "fixed",
		fixed = {
		{-0.5,-0.5,-0.5,0.5,-0.49,0.5}
		}
	},
	buildable_to = true,
	groups = {snappy = 3, flammable = 1, dig_immediate = 1, flower = 1},
	sounds = default.node_sound_leaves_defaults()
})
]]--
