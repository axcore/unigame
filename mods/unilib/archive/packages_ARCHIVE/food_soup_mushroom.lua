---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_craftitem("ethereal:mushroom_soup", {
	description = S("Mushroom Soup"),
	inventory_image = "ethereal_mushroom_soup.png",
	groups = {drink = 1},
	on_use = minetest.item_eat(5, "ethereal:bowl")
})
minetest.register_craft({
	output = "ethereal:mushroom_soup",
	recipe = {
		{"group:food_mushroom"},
		{"group:food_mushroom"},
		{"group:food_bowl"}
	}
})
]]--
