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
minetest.register_craftitem("icecream:vanilla", {
	description = S("Vanilla IceCream"),
	inventory_image = "icecream_vanilla.png",
	on_use = minetest.item_eat(10),
	groups = {food_icecream = 1}
})
minetest.register_craft({
	output = "icecream:vanilla",
	recipe = {
		{"default:snow"},
		{"farming:vanilla"},
		{"icecream:cone"},
	}
})

minetest.register_craftitem("icecream:vanilla_with_cookies", {
	description = S("Vanilla with Cookies IceCream"),
	inventory_image = "icecream_vanilla_and_cookie.png",
	on_use = minetest.item_eat(12),
	groups = {food_icecream = 1}
})
minetest.register_craft({
	output = "icecream:vanilla_with_cookies",
	recipe = {
		{"farming:cookie"},
		{"icecream:vanilla"},
	}
})
]]--
