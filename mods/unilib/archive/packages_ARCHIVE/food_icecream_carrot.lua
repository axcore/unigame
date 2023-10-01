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
minetest.register_craftitem("icecream:carrot", {
	description = S("Carrot IceCream"),
	inventory_image = "icecream_carrot.png",
	on_use = minetest.item_eat(6),
	groups = {food_icecream = 1}
})
minetest.register_craft({
	output = "icecream:carrot",
	recipe = {
		{"default:snow"},
		{"farming:carrot"},
		{"icecream:cone"},
	}
})
]]--
