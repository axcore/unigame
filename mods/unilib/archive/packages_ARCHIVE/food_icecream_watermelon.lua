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
minetest.register_craftitem("icecream:watermelon", {
	description = S("Watermelon IceCream"),
	inventory_image = "icecream_watermelon.png",
	on_use = minetest.item_eat(6),
	groups = {food_icecream = 1}
})
minetest.register_craft({
	output = "icecream:watermelon",
	recipe = {
		{"default:snow"},
		{"farming:melon_slice"},
		{"icecream:cone"},
	}
})
]]--
