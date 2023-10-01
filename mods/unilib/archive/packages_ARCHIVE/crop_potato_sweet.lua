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
farming.register_plant("cropocalypse:potato", {
	description = ("Potato Seed"),
	harvest_description = ("Sweet Potato"),
	paramtype2 = "meshoptions",
	inventory_image = "cropocalypse_potato_seed.png",
	steps = 8,
	minlight = 13,
	maxlight = default.LIGHT_MAX,
	fertility = {"grassland", "desert"},
	groups = {food_potato = 1, flammable = 4},
	place_param2 = 3,
})

minetest.register_craftitem("cropocalypse:potato", {
	description = ("Sweet Potato"),
	inventory_image = "cropocalypse_potato.png",
	wield_image = "cropocalypse_potato.png",
	paramtype = "meshoptions",
	groups = {food_potato = 1, flammable = 4},
	on_use = minetest.item_eat(1),
})

minetest.register_craft({
	output = "dye:magenta 2",
	recipe = {
		{"cropocalypse:potato"}
	},
})
]]--
