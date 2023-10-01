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
minetest.register_craftitem("cropocalypse:soy_milk", {
	description = ("Soy Milk"),
	inventory_image = "cropocalypse_soy_milk.png",
	on_use = minetest.item_eat(4),
	groups = {food_soy_milk = 1, flammable = 1},
})
minetest.register_craft({
	type = "cooking",
	output = "cropocalypse:soy_milk",
	recipe = "cropocalypse:soybean_water",
})
]]--
