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
minetest.register_craftitem("icecream:blueberries", {
	description = S("Blueberries IceCream"),
	inventory_image = "icecream_blueberries.png",
	on_use = minetest.item_eat(6),
	groups = {food_icecream = 1}
})
minetest.register_craft({
	output = "icecream:blueberries",
	recipe = {
		{"default:snow"},
		{"default:blueberries"},
		{"icecream:cone"},
	}
})
]]--
