---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    better_farming
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.produce_corn_flint = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.better_farming.add_mode

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
local minlight = 7
local maxlight = default.LIGHT_MAX

-- corn
minetest.register_craftitem("better_farming:corn", {
	description = "corn",
	inventory_image = "better_farming_corn.png",
	groups = {seed = 2, food_corn = 1, flammable = 2},
	on_place = function(itemstack, placer, pointed_thing)
		return farming.place_seed(itemstack, placer, pointed_thing, "better_farming:corn_1")
	end,
	on_use = minetest.item_eat(1)
})

-- corn definition
local def = {
	drawtype = "plantlike",
	tiles = {"better_farming_corn_1.png"},
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
minetest.register_node("better_farming:corn_1", table.copy(def))


-- stage 2
def.tiles = {"better_farming_corn_2.png"}
minetest.register_node("better_farming:corn_2", table.copy(def))


-- stage 3
def.tiles = {"better_farming_corn_3.png"}
minetest.register_node("better_farming:corn_3", table.copy(def))


-- stage 4
def.tiles = {"better_farming_corn_4.png"}
minetest.register_node("better_farming:corn_4", table.copy(def))

-- stage 5
def.tiles = {"better_farming_corn_5.png"}
def.visual_scale = 1.95
minetest.register_node("better_farming:corn_5", table.copy(def))

-- stage 6
def.tiles = {"better_farming_corn_6.png"}
minetest.register_node("better_farming:corn_6", table.copy(def))


-- stage 7
def.tiles = {"better_farming_corn_7.png"}
def.drop = {
	items = {
		{items = {"better_farming:corn"}, rarity = 1},
		{items = {"better_farming:corn 2"}, rarity = 3}
	}
}
minetest.register_node("better_farming:corn_7", table.copy(def))


-- stage 8
def.tiles = {"better_farming_corn_8.png"}
def.drop = {
	items = {
		{items = {"better_farming:corn"}, rarity = 1},
		{items = {"better_farming:corn 2"}, rarity = 3}
	}
}
minetest.register_node("better_farming:corn_8", table.copy(def))


-- add to registered_plants
farming.registered_plants["better_farming:corn"] = {
	crop = "better_farming:corn",
	seed = "better_farming:corn",
	minlight = farming.min_light,
	maxlight = farming.max_light,
	steps = 8
}
-- needed
minetest.override_item("better_farming:corn", {
	description = minetest.colorize("Yellow","Corn (Seed)"),
	on_use = minetest.item_eat(1),
})

minetest.register_decoration({
	name = "better_farming:corn_8",
	deco_type = "simple",
	place_on = {"default:dirt_with_grass"},
	sidelen = 16,
	noise_params = {
		offset = -0.1,
		scale = 0.1,
		spread = {x = 50, y = 50, z = 50},
		seed = 4487,
		octaves = 3,
		persist = 0.7
	},
	biomes = {"grassland", "deciduous_forest"},
	y_max = 31000,
	y_min = 1,
	decoration = "better_farming:corn_8",
	param2 = 3,
})
]]--
