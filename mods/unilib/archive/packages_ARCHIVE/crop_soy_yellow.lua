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
farming.register_plant("cropocalypse:soybean", {
	description = ("Soybean Seed"),
	harvest_description = ("Soybean"),
	inventory_image = "cropocalypse_soybean_seed.png",
	steps = 8,
	minlight = 13,
	maxlight = default.LIGHT_MAX,
	fertility = {"grassland", "desert"},
	groups = {food_soybean = 1, flammable = 4},
})
minetest.register_craft({
	output = "dye:green 2",
	recipe = {
		{"cropocalypse:soybean"}
	},
})

minetest.register_craftitem("cropocalypse:soybean", {
	description = ("Soybean"),
	inventory_image = "cropocalypse_soybean.png",
	wield_image = "cropocalypse_soybean.png",
	paramtype = "meshoptions",
	groups = {food_soybean = 1, flammable = 4},
	on_use = minetest.item_eat(1),
})
]]--
