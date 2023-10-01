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
farming.register_plant("farming:cotton", {
	description = S("Cotton Seed"),
	harvest_description = S("Cotton"),
	inventory_image = "farming_cotton_seed.png",
	steps = 8,
	minlight = 13,
	maxlight = default.LIGHT_MAX,
	fertility = {"grassland", "desert"},
	groups = {flammable = 4},
})
minetest.register_craft({
	type = "fuel",
	recipe = "farming:cotton",
	burntime = 1,
})
]]--

--[[
minetest.register_node("farming:seed_cotton", {
	description = S("Cotton Seed"),
	tiles = {"farming_cotton_seed.png"},
	inventory_image = "farming_cotton_seed.png",
	wield_image = "farming_cotton_seed.png",
	drawtype = "signlike",
	groups = {seed = 1, snappy = 3, attached_node = 1, flammable = 4},
	paramtype = "light",
	paramtype2 = "wallmounted",
	walkable = false,
	sunlight_propagates = true,
	selection_box = farming.select,
	on_place = function(itemstack, placer, pointed_thing)
		return farming.place_seed(itemstack, placer, pointed_thing, "farming:cotton_1")
	end
})

minetest.register_craftitem("farming:cotton", {
	description = S("Cotton"),
	inventory_image = "farming_cotton.png",
	groups = {flammable = 4}
})

local def = {
	drawtype = "plantlike",
	tiles = {"farming_cotton_1.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	drop =  "",
	selection_box = farming.select,
	groups = {
		snappy = 3, flammable = 4, plant = 1, attached_node = 1,
		not_in_creative_inventory = 1, growing = 1
	},
	sounds = default.node_sound_leaves_defaults()
}
-- stage 1
minetest.register_node("farming:cotton_1", table.copy(def))
-- stage 2
def.tiles = {"farming_cotton_2.png"}
minetest.register_node("farming:cotton_2", table.copy(def))
-- stage 3
def.tiles = {"farming_cotton_3.png"}
minetest.register_node("farming:cotton_3", table.copy(def))
-- stage 4
def.tiles = {"farming_cotton_4.png"}
minetest.register_node("farming:cotton_4", table.copy(def))
-- stage 5
def.tiles = {"farming_cotton_5.png"}
def.drop = {
	items = {
		{items = {"farming:seed_cotton"}, rarity = 1}
	}
}
minetest.register_node("farming:cotton_5", table.copy(def))
-- stage 6
def.tiles = {"farming_cotton_6.png"}
def.drop = {
	items = {
		{items = {"farming:cotton"}, rarity = 1},
		{items = {"farming:cotton"}, rarity = 2}
	}
}
minetest.register_node("farming:cotton_6", table.copy(def))
-- stage 7
def.tiles = {"farming_cotton_7.png"}
def.drop = {
	items = {
		{items = {"farming:cotton"}, rarity = 1},
		{items = {"farming:cotton"}, rarity = 2},
		{items = {"farming:seed_cotton"}, rarity = 1},
		{items = {"farming:seed_cotton"}, rarity = 2}
	}
}
minetest.register_node("farming:cotton_7", table.copy(def))
-- stage 8 (final)
def.tiles = {"farming_cotton_8.png"}
def.groups.growing = nil
def.drop = {
	items = {
		{items = {"farming:cotton"}, rarity = 1},
		{items = {"farming:cotton"}, rarity = 2},
		{items = {"farming:cotton"}, rarity = 3},
		{items = {"farming:seed_cotton"}, rarity = 1},
		{items = {"farming:seed_cotton"}, rarity = 2},
		{items = {"farming:seed_cotton"}, rarity = 3}
	}
}
minetest.register_node("farming:cotton_8", table.copy(def))

-- add to registered_plants
farming.registered_plants["farming:cotton"] = {
	crop = "farming:cotton",
	seed = "farming:seed_cotton",
	minlight = farming.min_light,
	maxlight = farming.max_light,
	steps = 8
}
]]--
