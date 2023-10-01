---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("australia:mangrove_fern", {
	description = "Acrostichum speciosum: Mangrove Fern",
	drawtype = "plantlike",
	waving = 1,
	visual_scale = 1.0,
	tiles = {"aus_mangrove_fern.png"},
	inventory_image = "aus_mangrove_fern.png",
	wield_image = "aus_mangrove_fern.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = false,
	groups = {snappy = 3, flammable = 2, flora = 1, attached_node = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.3125, 0.5},
	},
})

minetest.register_decoration({
	deco_type = "simple",
	place_on = {"australia:mangrove_mud",
		"default:dirt",
		"default:dirt_with_grass"},
	sidelen = 80,
	fill_ratio = 0.2,
	biomes = {"mangroves"},
	y_min = 2,
	y_max = 3,
	decoration = "australia:mangrove_fern",
})
]]--
