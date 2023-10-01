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
farming.register_plant("farming:wheat", {
	description = S("Wheat Seed"),
	harvest_description = S("Wheat"),
	paramtype2 = "meshoptions",
	inventory_image = "farming_wheat_seed.png",
	steps = 8,
	minlight = 13,
	maxlight = default.LIGHT_MAX,
	fertility = {"grassland"},
	groups = {food_wheat = 1, flammable = 4},
	place_param2 = 3,
})
minetest.register_craft({
	type = "fuel",
	recipe = "farming:wheat",
	burntime = 1,
})
]]--

--[[
minetest.register_node("farming:seed_wheat", {
	description = S("Wheat Seed"),
	tiles = {"farming_wheat_seed.png"},
	inventory_image = "farming_wheat_seed.png",
	wield_image = "farming_wheat_seed.png",
	drawtype = "signlike",
	groups = {seed = 1, snappy = 3, attached_node = 1, flammable = 4},
	paramtype = "light",
	paramtype2 = "wallmounted",
	walkable = false,
	sunlight_propagates = true,
	selection_box = farming.select,
	on_place = function(itemstack, placer, pointed_thing)
		return farming.place_seed(itemstack, placer, pointed_thing, "farming:wheat_1")
	end
})

minetest.register_craftitem("farming:wheat", {
	description = S("Wheat"),
	inventory_image = "farming_wheat.png",
	groups = {food_wheat = 1, flammable = 4}
})

local def = {
	drawtype = "plantlike",
	tiles = {"farming_wheat_1.png"},
	paramtype = "light",
	paramtype2 = "meshoptions",
	place_param2 = 3,
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	drop = "",
	selection_box = farming.select,
	groups = {
		snappy = 3, flammable = 4, plant = 1, attached_node = 1,
		not_in_creative_inventory = 1, growing = 1
	},
	sounds = default.node_sound_leaves_defaults()
}
-- stage 1
minetest.register_node("farming:wheat_1", table.copy(def))
-- stage 2
def.tiles = {"farming_wheat_2.png"}
minetest.register_node("farming:wheat_2", table.copy(def))
-- stage 3
def.tiles = {"farming_wheat_3.png"}
minetest.register_node("farming:wheat_3", table.copy(def))
-- stage 4
def.tiles = {"farming_wheat_4.png"}
minetest.register_node("farming:wheat_4", table.copy(def))
-- stage 5
def.tiles = {"farming_wheat_5.png"}
def.drop = {
	items = {
		{items = {"farming:wheat"}, rarity = 2},
		{items = {"farming:seed_wheat"}, rarity = 2}
	}
}
minetest.register_node("farming:wheat_5", table.copy(def))
-- stage 6
def.tiles = {"farming_wheat_6.png"}
def.drop = {
	items = {
		{items = {"farming:wheat"}, rarity = 2},
		{items = {"farming:seed_wheat"}, rarity = 1}
	}
}
minetest.register_node("farming:wheat_6", table.copy(def))
-- stage 7
def.tiles = {"farming_wheat_7.png"}
def.drop = {
	items = {
		{items = {"farming:wheat"}, rarity = 1},
		{items = {"farming:wheat"}, rarity = 3},
		{items = {"farming:seed_wheat"}, rarity = 1},
		{items = {"farming:seed_wheat"}, rarity = 3}
	}
}
minetest.register_node("farming:wheat_7", table.copy(def))
-- stage 8 (final)
def.tiles = {"farming_wheat_8.png"}
def.groups.growing = nil
def.drop = {
	items = {
		{items = {"farming:wheat"}, rarity = 1},
		{items = {"farming:wheat"}, rarity = 3},
		{items = {"farming:seed_wheat"}, rarity = 1},
		{items = {"farming:seed_wheat"}, rarity = 3}
	}
}
minetest.register_node("farming:wheat_8", table.copy(def))

-- add to registered_plants
farming.registered_plants["farming:wheat"] = {
	crop = "farming:wheat",
	seed = "farming:seed_wheat",
	minlight = farming.min_light,
	maxlight = farming.max_light,
	steps = 8
}
]]--
