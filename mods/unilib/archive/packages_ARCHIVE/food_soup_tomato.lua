---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_craftitem("farming:tomato_soup", {
	description = S("Tomato Soup"),
	inventory_image = "farming_tomato_soup.png",
	groups = {flammable = 2},
	on_use = minetest.item_eat(8, "farming:bowl")
})
minetest.register_craft({
	output = "farming:tomato_soup",
	recipe = {
		{"group:food_tomato"},
		{"group:food_tomato"},
		{"group:food_bowl"}
	}
})
]]--
