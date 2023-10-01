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
minetest.register_craftitem("icecream:orange", {
	description = S("Orange IceCream"),
	inventory_image = "icecream_orange.png",
	on_use = minetest.item_eat(8),
	groups = {food_icecream = 1}
})
minetest.register_craft({
	output = "icecream:orange",
	recipe = {
		{"default:snow"},
		{"ethereal:orange"},
		{"icecream:cone"},
	}
})
]]--
