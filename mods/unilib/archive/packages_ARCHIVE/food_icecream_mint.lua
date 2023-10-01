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
minetest.register_craftitem("icecream:mint", {
	description = S("Mint IceCream"),
	inventory_image = "icecream_mint.png",
	on_use = minetest.item_eat(12),
	groups = {food_icecream = 1}
})
minetest.register_craft({
	output = "icecream:mint",
	recipe = {
		{"default:snow"},
		{"farming:mint_leaf"},
		{"icecream:cone"},
	}
})
]]--
