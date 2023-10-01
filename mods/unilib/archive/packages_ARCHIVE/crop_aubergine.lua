---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    better_farming
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
local minlight = 7
local maxlight = default.LIGHT_MAX

-- eggplants
farming.register_plant("better_farming:eggplants", {
	description = minetest.colorize("Yellow","Eggplants Seed"),
	inventory_image = "better_farming_eggplants_seed.png",
	steps = 4,
	drawtype = "plantlike",
	waving = 1,
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	minlight = minlight,
	maxlight = maxlight,
	fertility = {"grassland"},
	groups = {flammable = 4},
	place_param2 = 3,
	on_use = minetest.item_eat(1),
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -8 / 16, -6 / 16, 6 / 16, 5 / 16, 6 / 16},
	},
})

-- needed
minetest.override_item("better_farming:eggplants", {
	description = minetest.colorize("Yellow","Eggplants (Not a seed)"),
	on_use = minetest.item_eat(3),
	inventory_image = "better_farming_eggplants.png",
	groups = {food_tomato = 1, flammable = 3}
})

minetest.register_decoration({
	name = "better_farming:eggplants_4",
	deco_type = "simple",
	place_on = {"default:dirt_with_grass"},
	sidelen = 16,
	noise_params = {
		offset = -0.1,
		scale = 0.1,
		spread = {x = 50, y = 50, z = 50},
		seed = 3145,
		octaves = 3,
		persist = 0.7
	},
	biomes = {"deciduous_forest"},
	y_max = 31000,
	y_min = 1,
	decoration = "better_farming:eggplants_4",
	param2 = 3,
})
]]--
