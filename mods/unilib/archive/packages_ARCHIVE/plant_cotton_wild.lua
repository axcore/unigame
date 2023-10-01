---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("farming:cotton_wild", {
	description = S("Wild Cotton"),
	drawtype = "plantlike",
	waving = 1,
	tiles = {"farming_cotton_wild.png"},
	inventory_image = "farming_cotton_wild.png",
	wield_image = "farming_cotton_wild.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	groups = {snappy = 3, attached_node = 1, flammable = 4},
	drop = "farming:seed_cotton",
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -8 / 16, -6 / 16, 6 / 16, 5 / 16, 6 / 16},
	},
})

minetest.register_decoration({
	name = "farming:cotton_wild",
	deco_type = "simple",
	place_on = {"default:dry_dirt_with_dry_grass"},
	sidelen = 16,
	noise_params = {
		offset = -0.1,
		scale = 0.1,
		spread = {x = 50, y = 50, z = 50},
		seed = 4242,
		octaves = 3,
		persist = 0.7
	},
	biomes = {"savanna"},
	y_max = 31000,
	y_min = 1,
	decoration = "farming:cotton_wild",
})
]]--
