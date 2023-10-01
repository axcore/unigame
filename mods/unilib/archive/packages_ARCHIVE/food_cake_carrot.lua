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
minetest.register_craftitem("cropocalypse:carrot_cake", {
	description = ("Carrot Cake"),
	inventory_image = "cropocalypse_carrot_cake.png",
	on_use = minetest.item_eat(7),
	groups = {food_carrot_cake = 1, flammable = 1},
})
minetest.register_craft({
	type = "shapeless",
	output = "cropocalypse:carrot_cake",
	recipe = {
		"farming:flour", "farming:flour", "cropocalypse:sugar",
		"cropocalypse:sliced_carrots", "cropocalypse:sliced_carrots", "cropocalypse:sliced_carrots",
		"cropocalypse:soy_milk"
	}
})
]]--
