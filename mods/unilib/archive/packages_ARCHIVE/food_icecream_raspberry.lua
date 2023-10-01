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
--raspberry icecream
minetest.register_craftitem("icecream:raspberry", {
	description = S("Raspberry IceCream"),
	inventory_image = "icecream_raspberry.png",
	on_use = minetest.item_eat(8),
	groups = {food_icecream = 1}
})
minetest.register_craft({
	output = "icecream:raspberry",
	recipe = {
		{"default:snow"},
		{"farming:raspberries"},
		{"icecream:cone"},
	}
})
]]--
