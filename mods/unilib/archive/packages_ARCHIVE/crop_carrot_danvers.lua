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
farming.register_plant("cropocalypse:carrot", {
	description = ("Carrot Seed"),
	harvest_description = ("Carrot Root"),
	paramtype2 = "meshoptions",
	inventory_image = "cropocalypse_carrot_seed.png",
	steps = 8,
	minlight = 13,
	maxlight = default.LIGHT_MAX,
	fertility = {"grassland", "desert"},
	groups = {food_carrot = 1, flammable = 4},
	place_param2 = 3,
})

minetest.register_craftitem("cropocalypse:carrot", {
	description = ("Carrot"),
	inventory_image = "cropocalypse_carrot.png",
	wield_image = "cropocalypse_carrot.png",
	paramtype = "meshoptions",
	groups = {food_carrot = 1, flammable = 4},
	on_use = minetest.item_eat(1),
})

minetest.register_craft({
	output = "dye:orange 2",
	recipe = {
		{"cropocalypse:carrot"}
	},
})
]]--
