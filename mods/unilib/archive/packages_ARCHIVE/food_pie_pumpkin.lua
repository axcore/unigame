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
minetest.register_craftitem("cropocalypse:uncooked_pumpkin_pie", {
	description = ("Uncooked Pumpkin Pie"),
	inventory_image = "cropocalypse_uncooked_pumpkin_pie.png",
	on_use = minetest.item_eat(4),
	groups = {food_uncooked_pumpkin_pie = 1, flammable = 1},
})
minetest.register_craft({
	type = "shapeless",
	output = "cropocalypse:uncooked_pumpkin_pie",
	recipe = {
		"farming:flour", "cropocalypse:sugar", "cropocalypse:sugar",
		"cropocalypse:pumpkin_chunk", "cropocalypse:pumpkin_chunk", "cropocalypse:pumpkin_chunk",
		"cropocalypse:soy_milk"
	}
})

minetest.register_craftitem("cropocalypse:cooked_pumpkin_pie", {
	description = ("Cooked Pumpkin Pie"),
	inventory_image = "cropocalypse_cooked_pumpkin_pie.png",
	on_use = minetest.item_eat(8),
	groups = {food_cooked_pumpkin_pie = 1, flammable = 1},
})
minetest.register_craft({
	type = "cooking",
	output = "cropocalypse:cooked_pumpkin_pie",
	recipe = "cropocalypse:uncooked_pumpkin_pie",
})
]]--
