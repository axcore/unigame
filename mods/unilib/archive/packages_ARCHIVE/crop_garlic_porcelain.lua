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
farming.register_plant("cropocalypse:garlic", {
	description = ("Garlic Seed"),
	harvest_description = ("Garlic"),
	paramtype2 = "meshoptions",
	inventory_image = "cropocalypse_garlic_seed.png",
	steps = 8,
	minlight = 13,
	maxlight = default.LIGHT_MAX,
	fertility = {"grassland", "desert"},
	groups = {food_garlic = 1, flammable = 4},
	place_param2 = 3,
})

minetest.register_craftitem("cropocalypse:garlic", {
	description = ("Garlic"),
	inventory_image = "cropocalypse_garlic.png",
	wield_image = "cropocalypse_garlic.png",
	paramtype = "meshoptions",
	groups = {food_garlic = 1, flammable = 4},
	on_use = minetest.item_eat(1),
})

minetest.register_craft({
	output = "dye:grey 2",
	recipe = {
		{"cropocalypse:garlic"}
	},
})
]]--
