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

-- potatoes
minetest.register_craftitem("better_farming:potatoes", {
	description = "Potatoes",
	inventory_image = "better_farming_potatoes.png",
	groups = {seed = 2, food_potatoes = 1, flammable = 2},
	on_place = function(itemstack, placer, pointed_thing)
		return farming.place_seed(itemstack, placer, pointed_thing, "better_farming:potatoes_1")
	end,
	on_use = minetest.item_eat(1)
})

-- potatoes definition
local def = {
	drawtype = "plantlike",
	tiles = {"better_farming_potatoes_1.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	drop = "",
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -8 / 8, -6 / 16, 6 / 16, 1 / 55, 6 / 16},
	},
	groups = {
		snappy = 3, flammable = 2, plant = 1, attached_node = 1,
		not_in_creative_inventory = 1, growing = 1
	},
	sounds = default.node_sound_leaves_defaults()
}

-- stage 1
minetest.register_node("better_farming:potatoes_1", table.copy(def))


-- stage 2
def.tiles = {"better_farming_potatoes_2.png"}
minetest.register_node("better_farming:potatoes_2", table.copy(def))


-- stage 3
def.tiles = {"better_farming_potatoes_3.png"}
def.drop = {
	items = {
		{items = {"better_farming:potatoes"}, rarity = 1},
		{items = {"better_farming:potatoes 2"}, rarity = 3}
	}
}
minetest.register_node("better_farming:potatoes_3", table.copy(def))

-- stage 4
def.tiles = {"better_farming_potatoes_4.png"}
def.drop = {
	items = {
		{items = {"better_farming:potatoes 2"}, rarity = 1},
		{items = {"better_farming:potatoes 2"}, rarity = 3}
	}
}
minetest.register_node("better_farming:potatoes_4", table.copy(def))

-- add to registered_plants
farming.registered_plants["better_farming:potatoes"] = {
	crop = "better_farming:potatoes",
	seed = "better_farming:potatoes",
	minlight = farming.min_light,
	maxlight = farming.max_light,
	steps = 4
}
-- needed
minetest.override_item("better_farming:potatoes", {
	description = minetest.colorize("Yellow","Potatoes (Seed)"),
	on_use = minetest.item_eat(1),
})

minetest.register_decoration({
	name = "better_farming:potatoes_4",
	deco_type = "simple",
	place_on = {"default:dirt_with_rainforest_litter", "default:dirt_with_coniferous_litter"},
	sidelen = 16,
	noise_params = {
		offset = -0.1,
		scale = 0.1,
		spread = {x = 50, y = 50, z = 50},
		seed = 2008,
		octaves = 3,
		persist = 0.7
	},
	biomes = {"rainforest", "coniferous_forest"},
	y_max = 31000,
	y_min = 1,
	decoration = "better_farming:potatoes_4",
	param2 = 3,
})
]]--
