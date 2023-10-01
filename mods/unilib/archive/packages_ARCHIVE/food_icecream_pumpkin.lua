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
minetest.register_craftitem("icecream:pumpkin", {
	description = S("Pumpkin IceCream"),
	inventory_image = "icecream_pumpkin.png",
	on_use = minetest.item_eat(6),
	groups = {food_icecream = 1}
})
minetest.register_craft({
	output = "icecream:pumpkin",
	recipe = {
		{"default:snow"},
		{"farming:pumpkin_slice"},
		{"icecream:cone"},
	}
})
]]--
