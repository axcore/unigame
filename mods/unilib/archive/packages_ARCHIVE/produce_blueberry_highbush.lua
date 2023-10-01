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
minetest.register_craftitem("farming:blueberries", {
	description = S("Wild Blueberries"),
	inventory_image = "farming_blueberries.png",
	groups = {seed = 2, food_blueberries = 1, food_blueberry = 1,
			food_berry = 1, flammable = 2},
	on_place = function(itemstack, placer, pointed_thing)
		return farming.place_seed(itemstack, placer, pointed_thing, "farming:blueberry_1")
	end,
	on_use = minetest.item_eat(1)
})

local def = {
	drawtype = "plantlike",
	tiles = {"farming_blueberry_1.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	drop = "",
	selection_box = farming.select,
	groups = {
		snappy = 3, flammable = 2, plant = 1, attached_node = 1,
		not_in_creative_inventory = 1, growing = 1
	},
	sounds = default.node_sound_leaves_defaults()
}
-- stage 1
minetest.register_node("farming:blueberry_1", table.copy(def))
-- stage 2
def.tiles = {"farming_blueberry_2.png"}
minetest.register_node("farming:blueberry_2", table.copy(def))
-- stage 3
def.tiles = {"farming_blueberry_3.png"}
minetest.register_node("farming:blueberry_3", table.copy(def))
-- stage 4 (final)
def.tiles = {"farming_blueberry_4.png"}
def.groups.growing = nil
def.drop = {
	items = {
		{items = {"farming:blueberries 2"}, rarity = 1},
		{items = {"farming:blueberries"}, rarity = 2},
		{items = {"farming:blueberries"}, rarity = 3}
	}
}
minetest.register_node("farming:blueberry_4", table.copy(def))

-- add to registered_plants
farming.registered_plants["farming:blueberries"] = {
	crop = "farming:blueberry",
	seed = "farming:blueberries",
	minlight = farming.min_light,
	maxlight = farming.max_light,
	steps = 4
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
register_plant("blueberry_4", 3, 10, nil, "", -1, farming.blueberry)
]]--
