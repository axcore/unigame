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
minetest.register_craftitem("icecream:garlic", {
	description = S("Garlic IceCream!?"),
	inventory_image = "icecream_garlic.png",
	on_use = minetest.item_eat(4),
	groups = {food_icecream = 1}
})
minetest.register_craft({
	output = "icecream:garlic",
	recipe = {
		{"default:snow"},
		{"farming:garlic_clove"},
		{"icecream:cone"},
	}
})
]]--
