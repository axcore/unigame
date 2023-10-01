---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    icecream
-- Code:    GPL-3.0
-- Media:   GPL-3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_craftitem("icecream:chocolate", {
	description = S("Chocolate IceCream"),
	inventory_image = "icecream_chocolate.png",
	on_use = minetest.item_eat(8),
	groups = {food_icecream = 1}
})
minetest.register_craft({
	output = "icecream:chocolate",
	recipe = {
		{"default:snow"},
		{"farming:chocolate_dark"},
		{"icecream:cone"},
	}
})

minetest.register_craftitem("icecream:chocolate_with_cookies", {
	description = S("Chocolate with Cookies IceCream"),
	inventory_image = "icecream_chocolate_and_cookie.png",
	on_use = minetest.item_eat(12),
	groups = {food_icecream = 1}
})
minetest.register_craft({
	output = "icecream:chocolate_with_cookies",
	recipe = {
		{"farming:cookie"},
		{"icecream:chocolate"},
	}
})
]]--
