---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
farming.register_plant("cropocalypse:corn", {
	description = ("Corn Seed"),
	harvest_description = ("Corn"),
	paramtype2 = "meshoptions",
	inventory_image = "cropocalypse_corn_seed.png",
	steps = 8,
	minlight = 13,
	maxlight = default.LIGHT_MAX,
	fertility = {"grassland", "desert"},
	groups = {food_corn = 1, flammable = 4},
	place_param2 = 3,
})

minetest.register_craftitem("cropocalypse:corn", {
	description = ("Corn"),
	inventory_image = "cropocalypse_corn.png",
	wield_image = "cropocalypse_corn.png",
	paramtype = "meshoptions",
	groups = {food_corn = 1, flammable = 4},
	on_use = minetest.item_eat(2),
})

-- Corn Crop Size Overides As It Grows
minetest.override_item("cropocalypse:corn_4", {
	visual_scale = 2.0
})
minetest.override_item("cropocalypse:corn_5", {
	visual_scale = 2.0
})
minetest.override_item("cropocalypse:corn_6", {
	visual_scale = 3.0
})
minetest.override_item("cropocalypse:corn_7", {
	visual_scale = 3.0
})
minetest.override_item("cropocalypse:corn_8", {
	visual_scale = 3.0
})

minetest.register_craft({
	output = "dye:yellow 2",
	recipe = {
		{"cropocalypse:corn"}
	},
})
]]--
