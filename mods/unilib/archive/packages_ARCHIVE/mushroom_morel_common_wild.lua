---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("cropocalypse:morel_mushroom_wild", {
	description = ("Wild Morel Mushroom"),
	drawtype = "plantlike",
	waving = 0,
	tiles = {"cropocalypse_morel_mushroom_wild.png"},
	inventory_image = "cropocalypse_morel_mushroom_wild.png",
	wield_image = "cropocalypse_morel_mushroom_wild.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	groups = {snappy = 3, attached_node = 1, flammable = 4},
	drop = "cropocalypse:seed_morel_mushroom",
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -8 / 16, -6 / 16, 6 / 16, 5 / 16, 6 / 16},
	},
})

minetest.register_decoration({
	name = "cropocalypse:morel_mushroom_wild",
	deco_type = "simple",
	place_on = {"default:dirt_with_coniferous_litter"},
	sidelen = 16,
	noise_params = {
		offset = -0.1,
		scale = 0.1,
		spread = {x = 50, y = 50, z = 50},
		seed = 3961,
		octaves = 3,
		persist = 0.7
	},
	biomes = {"coniferous_forest"},
	y_max = 31000,
	y_min = 1,
	decoration = "cropocalypse:morel_mushroom_wild",
})
]]--
