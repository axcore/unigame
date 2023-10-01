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
minetest.register_craftitem("cropocalypse:uncooked_garlic_bread", {
	description = ("Uncooked Garlic Bread"),
	inventory_image = "cropocalypse_uncooked_garlic_bread.png",
	on_use = minetest.item_eat(3),
	groups = {food_uncooked_garlic_bread = 1, flammable = 1},
})
minetest.register_craft({
	type = "shapeless",
	output = "cropocalypse:uncooked_garlic_bread",
	recipe = {"farming:bread", "cropocalypse:soy_butter", "cropocalypse:garlic"}
})

minetest.register_craftitem("cropocalypse:cooked_garlic_bread", {
	description = ("Cooked Garlic Bread"),
	inventory_image = "cropocalypse_cooked_garlic_bread.png",
	on_use = minetest.item_eat(8),
	groups = {food_cooked_garlic_bread = 1, flammable = 1},
})
minetest.register_craft({
	type = "cooking",
	output = "cropocalypse:cooked_garlic_bread",
	recipe = "cropocalypse:uncooked_garlic_bread",
})
]]--
