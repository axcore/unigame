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
minetest.register_craftitem("icecream:apple", {
	description = S("Apple IceCream"),
	inventory_image = "icecream_apple.png",
	on_use = minetest.item_eat(8),
	groups = {food_icecream = 1}
})
minetest.register_craft({
	output = "icecream:apple",
	recipe = {
		{"default:snow"},
		{"default:apple"},
		{"icecream:cone"},
	}
})
]]--
