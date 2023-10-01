---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cucina_vegana
-- Code:    LGPL3.0
-- Media:   LGPL3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
cucina_vegana.plant_settings.parsley = minetest.settings:get_bool(cv_setting .."parsley", true)
cucina_vegana.plant_settings.parsley_scale = minetest.settings:get(cv_setting .."parsley_scale") or 0.0005
cucina_vegana.plant_settings.parsley_light = minetest.settings:get(cv_setting .."parsley_light") or 11

minetest.register_craftitem("cucina_vegana:parsley", {
	description = S("Parsley"),
	inventory_image = "cucina_vegana_parsley.png",
	groups = {flammable = 1, food = 1, eatable = 1, food_vegan = 1, food_parsley = 1},
	on_use = minetest.item_eat(1),
})

local dname = S("Parsley")
local pname = "parsley"
local step = 5

farming.register_plant("cucina_vegana:" .. pname, {
	description = dname .. " " .. S("Seed"),
    harvest_description = dname,
	inventory_image = "cucina_vegana_" .. pname .. "_seed.png",
	steps = step,
	minlight = cucina_vegana.plant_settings.parsley_light,
	fertility = {"grassland"},
	groups = {flammable = 4, attached_node = 1},
})

-- Parsley
minetest.register_node("cucina_vegana:" .. pname .. "_seed", {
	description = dname .. " " .. S("Seed"),
	tiles = {"cucina_vegana_" .. pname .. "_seed.png"},
	inventory_image = "cucina_vegana_" .. pname .. "_seed.png",
	wield_image = "cucina_vegana_" .. pname .. "_seed.png",
	drawtype = "signlike",
	minlight = cucina_vegana.plant_settings.parsley_light,
	groups = {seed = 1, snappy = 3, attached_node = 1, dig_immediate=1, flammable = 4},
	paramtype = "light",
	paramtype2 = "wallmounted",
	walkable = false,
	sunlight_propagates = true,
	selection_box = farming.select,
	on_place = function(itemstack, placer, pointed_thing)
		return farming.place_seed(itemstack, placer, pointed_thing, "cucina_vegana:" .. pname .. germ)
	end,
})

-- Parsley definition
local crop_def = {
	drawtype = "plantlike",
	tiles = {"cucina_vegana_" .. pname .. "_1.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
    waving = 1,
	minlight = cucina_vegana.plant_settings.parsley_light,
	buildable_to = true,
	drop =  "",
	selection_box = farming.select,
	groups = {
		flammable = 4, snappy=3, dig_immediate=1, plant = 1, attached_node = 1,
		not_in_creative_inventory = 1, growing = 1
	},
	sounds = default.node_sound_leaves_defaults()
}

-- stage 1
minetest.register_node("cucina_vegana:" .. pname .. "_1", table.copy(crop_def))

-- stage 2
crop_def.tiles = {"cucina_vegana_" .. pname .. "_2.png"}
minetest.register_node("cucina_vegana:" .. pname .. "_2", table.copy(crop_def))

-- stage 3
crop_def.tiles = {"cucina_vegana_" .. pname .. "_3.png"}
minetest.register_node("cucina_vegana:" .. pname .. "_3", table.copy(crop_def))

-- stage 4
crop_def.tiles = {"cucina_vegana_" .. pname .. "_4.png"}
crop_def.drop = {
	items = {
		{items = {"cucina_vegana:" .. pname .. ""}, rarity = 1},
		{items = {"cucina_vegana:" .. pname .. "_seed"}, rarity = 2},
	}
}
minetest.register_node("cucina_vegana:" .. pname .. "_4", table.copy(crop_def))

-- stage 5 (final)
crop_def.tiles = {"cucina_vegana_" .. pname .. "_" .. step .. ".png"}
crop_def.groups.growing = 0
crop_def.drop = {
	items = {
		{items = {"cucina_vegana:" .. pname .. ""}, rarity = 1},
		{items = {"cucina_vegana:" .. pname .. ""}, rarity = 1},
		{items = {"cucina_vegana:" .. pname .. ""}, rarity = 3},
		{items = {"cucina_vegana:" .. pname .. "_seed"}, rarity = 1},
		{items = {"cucina_vegana:" .. pname .. "_seed"}, rarity = 1},
		{items = {"cucina_vegana:" .. pname .. "_seed"}, rarity = 3},

	}
}
minetest.register_node("cucina_vegana:" .. pname .. "_5", table.copy(crop_def))

minetest.register_craft({
	type = "fuel",
	recipe = "cucina_vegana:parsley",
	burntime = 1,
})
]]--
