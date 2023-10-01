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
minetest.register_craftitem("icecream:strawberry", {
	description = S("Strawberry IceCream"),
	inventory_image = "icecream_strawberry.png",
	on_use = minetest.item_eat(10),
	groups = {food_icecream = 1}
})
minetest.register_craft({
	output = "icecream:strawberry",
	recipe = {
		{"default:snow"},
		{"ethereal:strawberry"},
		{"icecream:cone"},
	}
})
]]--
