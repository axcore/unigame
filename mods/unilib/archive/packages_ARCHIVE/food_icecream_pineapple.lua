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
minetest.register_craftitem("icecream:pineapple", {
	description = S("Pineapple IceCream"),
	inventory_image = "icecream_pineapple.png",
	on_use = minetest.item_eat(4),
	groups = {food_icecream = 1}
})
minetest.register_craft({
	output = "icecream:pineapple",
	recipe = {
		{"default:snow"},
		{"farming:pineapple_ring"},
		{"icecream:cone"},
	}
})
]]--
