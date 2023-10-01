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
minetest.register_craftitem("farming:soy_pod", {
	description = S("Soy Pod"),
	inventory_image = "farming_soy_pod.png",
	groups = {seed = 2, food_soy_pod = 1, flammable = 2},
	on_place = function(itemstack, placer, pointed_thing)
		return farming.place_seed(itemstack, placer, pointed_thing, "farming:soy_1")
	end
})

local def = {
	drawtype = "plantlike",
	tiles = {"farming_soy_1.png"},
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
		snappy = 3, flammable = 2, plant = 1, attached_node = 1,
		not_in_creative_inventory = 1, growing = 1
	},
	sounds = default.node_sound_leaves_defaults()
}
-- stage 1
minetest.register_node("farming:soy_1", table.copy(def))
-- stage 2
def.tiles = {"farming_soy_2.png"}
minetest.register_node("farming:soy_2", table.copy(def))
-- stage 3
def.tiles = {"farming_soy_3.png"}
minetest.register_node("farming:soy_3", table.copy(def))
-- stage 4
def.tiles = {"farming_soy_4.png"}
minetest.register_node("farming:soy_4", table.copy(def))
-- stage 5
def.tiles = {"farming_soy_5.png"}
def.drop = {
	max_items = 1, items = {
		{items = {"farming:soy_pod"}, rarity = 1},
	}
}
minetest.register_node("farming:soy_5", table.copy(def))
-- stage 6
def.tiles = {"farming_soy_6.png"}
def.drop = {
	max_items = 3, items = {
		{items = {"farming:soy_pod"}, rarity = 1},
		{items = {"farming:soy_pod"}, rarity = 2},
		{items = {"farming:soy_pod"}, rarity = 3},
	}
}
minetest.register_node("farming:soy_6", table.copy(def))
-- stage 7
def.tiles = {"farming_soy_7.png"}
def.groups.growing = nil
def.drop = {
	max_items = 5, items = {
		{items = {"farming:soy_pod"}, rarity = 1},
		{items = {"farming:soy_pod"}, rarity = 2},
		{items = {"farming:soy_pod"}, rarity = 3},
		{items = {"farming:soy_pod"}, rarity = 4},
		{items = {"farming:soy_pod"}, rarity = 5}
	}
}
minetest.register_node("farming:soy_7", table.copy(def))

-- add to registered_plants
farming.registered_plants["farming:soy_pod"] = {
	crop = "farming:soy",
	seed = "farming:soy_pod",
	minlight = farming.min_light,
	maxlight = farming.max_light,
	steps = 7
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
register_plant("soy_6", 20, 50, {"default:dirt_with_dry_grass",
    "default:dirt_with_rainforest_litter",
    "default:dry_dirt_with_dry_grass"}, "", -1, farming.soy)
]]--
