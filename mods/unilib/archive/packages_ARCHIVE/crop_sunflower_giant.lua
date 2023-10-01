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
minetest.register_craftitem("farming:sunflower", {
	description = S("Sunflower"),
	inventory_image = "farming_sunflower.png",
	groups = {flammable = 2}
})

minetest.register_craftitem("farming:seed_sunflower", {
	description = S("Sunflower Seeds"),
	inventory_image = "farming_sunflower_seeds.png",
	groups = {seed = 2, food_sunflower_seeds = 1, flammable = 2},
	on_place = function(itemstack, placer, pointed_thing)
		return farming.place_seed(itemstack, placer, pointed_thing, "farming:sunflower_1")
	end
})
minetest.register_craft({
	output = "farming:seed_sunflower 5",
	recipe = {{"farming:sunflower"}}
})
minetest.register_alias("farming:sunflower_seeds", "farming:seed_sunflower")

local def = {
	drawtype = "plantlike",
	tiles = {"farming_sunflower_1.png"},
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
minetest.register_node("farming:sunflower_1", table.copy(def))
-- stage 2
def.tiles = {"farming_sunflower_2.png"}
minetest.register_node("farming:sunflower_2", table.copy(def))
-- stage 3
def.tiles = {"farming_sunflower_3.png"}
minetest.register_node("farming:sunflower_3", table.copy(def))
-- stage 4
def.tiles = {"farming_sunflower_4.png"}
minetest.register_node("farming:sunflower_4", table.copy(def))
-- stage 5
def.tiles = {"farming_sunflower_5.png"}
minetest.register_node("farming:sunflower_5", table.copy(def))
-- stage 6
def.tiles = {"farming_sunflower_6.png"}
def.visual_scale = 1.9
minetest.register_node("farming:sunflower_6", table.copy(def))
-- stage 7
def.tiles = {"farming_sunflower_7.png"}
minetest.register_node("farming:sunflower_7", table.copy(def))
-- stage 8 (final)
def.tiles = {"farming_sunflower_8.png"}
def.groups.growing = nil
def.drop = {
	items = {
		{items = {"farming:sunflower"}, rarity = 1},
		{items = {"farming:sunflower"}, rarity = 6}
	}
}
minetest.register_node("farming:sunflower_8", table.copy(def))

-- add to registered_plants
farming.registered_plants["farming:sunflower"] = {
	crop = "farming:sunflower",
	seed = "farming:seed_sunflower",
	minlight = 14,
	maxlight = farming.max_light,
	steps = 8
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
register_plant("sunflower_8", 10, 40, nil, "", -1, farming.sunflower)
]]--