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
farming.register_plant("cropocalypse:beet", {
	description = ("Beet Seed"),
	harvest_description = ("Sugar Beet"),
	inventory_image = "cropocalypse_beet_seed.png",
	steps = 8,
	minlight = 13,
	maxlight = default.LIGHT_MAX,
	fertility = {"grassland", "desert"},
	groups = {food_beet = 1, flammable = 4},
})

minetest.register_craftitem("cropocalypse:beet", {
	description = ("Sugar Beet"),
	inventory_image = "cropocalypse_beet.png",
	wield_image = "cropocalypse_beet.png",
	paramtype = "meshoptions",
	groups = {food_beet = 1, flammable = 4},
	on_use = minetest.item_eat(1),
})
minetest.register_craft({
	output = "dye:white 2",
	recipe = {
		{"cropocalypse:beet"}
	},
})
]]--
