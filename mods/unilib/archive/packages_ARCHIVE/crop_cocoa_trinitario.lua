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
farming.register_plant("cropocalypse:cocao", {
	description = ("Cocao Seed"),
	harvest_description = ("Cocao"),
	inventory_image = "cropocalypse_cocao_seed.png",
	steps = 8,
	minlight = 13,
	maxlight = default.LIGHT_MAX,
	fertility = {"grassland", "desert"},
	groups = {food_cocao = 1, flammable = 4},
})

minetest.register_craftitem("cropocalypse:cocao", {
	description = ("Cocao"),
	inventory_image = "cropocalypse_cocao.png",
	wield_image = "cropocalypse_cocao.png",
	paramtype = "meshoptions",
	groups = {food_cocao = 1, flammable = 4},
	on_use = minetest.item_eat(1),
})

minetest.override_item("cropocalypse:cocao_4", {
	visual_scale = 2.0
})
minetest.override_item("cropocalypse:cocao_5", {
	visual_scale = 2.0
})
minetest.override_item("cropocalypse:cocao_6", {
	visual_scale = 3.0
})
minetest.override_item("cropocalypse:cocao_7", {
	visual_scale = 3.0
})
minetest.override_item("cropocalypse:cocao_8", {
	visual_scale = 3.0
})

minetest.register_craft({
	output = "dye:brown 2",
	recipe = {
		{"cropocalypse:cocao"}
	},
})
]]--
