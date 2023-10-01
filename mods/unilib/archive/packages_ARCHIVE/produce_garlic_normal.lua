---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_craftitem("farming:garlic", {
	description = S("Garlic"),
	inventory_image = "crops_garlic.png",
	on_use = minetest.item_eat(1),
	groups = {food_garlic = 1, flammable = 3}
})
minetest.register_craft({
	output = "farming:garlic",
	recipe = {
		{"farming:garlic_clove", "farming:garlic_clove", "farming:garlic_clove"},
		{"farming:garlic_clove", "", "farming:garlic_clove"},
		{"farming:garlic_clove", "farming:garlic_clove", "farming:garlic_clove"}
	}
})

minetest.register_craftitem("farming:garlic_clove", {
	description = S("Garlic clove"),
	inventory_image = "crops_garlic_clove.png",
	groups = {seed = 2, food_garlic_clove = 1, flammable = 3},
	on_place = function(itemstack, placer, pointed_thing)
		return farming.place_seed(itemstack, placer, pointed_thing, "farming:garlic_1")
	end
})
minetest.register_craft({
	type = "shapeless",
	output = "farming:garlic_clove 8",
	recipe = {"farming:garlic"}
})

local def = {
	drawtype = "plantlike",
	tiles = {"crops_garlic_plant_1.png"},
	paramtype = "light",
	paramtype2 = "meshoptions",
	place_param2 = 3,
	sunlight_propagates = true,
	waving = 1,
	walkable = false,
	buildable_to = true,
	drop = "",
	selection_box = farming.select,
	groups = {
		snappy = 3, flammable = 3, plant = 1, attached_node = 1,
		not_in_creative_inventory = 1, growing = 1
	},
	sounds = default.node_sound_leaves_defaults()
}

-- stage 1
minetest.register_node("farming:garlic_1", table.copy(def))

-- stage 2
def.tiles = {"crops_garlic_plant_2.png"}
minetest.register_node("farming:garlic_2", table.copy(def))

-- stage 3
def.tiles = {"crops_garlic_plant_3.png"}
minetest.register_node("farming:garlic_3", table.copy(def))

-- stage 4
def.tiles = {"crops_garlic_plant_4.png"}
minetest.register_node("farming:garlic_4", table.copy(def))

-- stage 5
def.tiles = {"crops_garlic_plant_5.png"}
def.groups.growing = nil
def.drop = {
	items = {
		{items = {"farming:garlic 3"}, rarity = 1},
		{items = {"farming:garlic"}, rarity = 2},
		{items = {"farming:garlic"}, rarity = 5}
	}
}
minetest.register_node("farming:garlic_5", table.copy(def))

-- add to registered_plants
farming.registered_plants["farming:garlic"] = {
	crop = "farming:garlic",
	seed = "farming:garlic_clove",
	minlight = farming.min_light,
	maxlight = farming.max_light,
	steps = 5
}

local function register_plant(name, min, max, spawnon, spawnby, num, rarety)

	-- do not place on mapgen if no value given (or not true)
	if not rarety then
		return
	end

	-- set rarety value or default to farming.rarety if not a number
	rarety = tonumber(rarety) or farming.rarety

	minetest.register_decoration({
		deco_type = "simple",
		place_on = spawnon or {"default:dirt_with_grass"},
		sidelen = 16,
		noise_params = {
			offset = 0,
			scale = rarety,
			spread = {x = 100, y = 100, z = 100},
			seed = 329,
			octaves = 3,
			persist = 0.6
		},
		y_min = min,
		y_max = max,
		decoration = "farming:" .. name,
		spawn_by = spawnby,
		num_spawn_by = num
	})
end
register_plant("garlic_5", 3, 30, nil, "group:tree", 1, farming.garlic)
]]--
