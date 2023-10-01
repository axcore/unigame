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
minetest.register_craftitem("farming:pea_soup", {
	description = S("Pea Soup"),
	inventory_image = "farming_pea_soup.png",
	groups = {flammable = 2},
	on_use = minetest.item_eat(4, "farming:bowl")
})
minetest.register_craft({
	output = "farming:pea_soup",
	recipe = {
		{"group:food_peas"},
		{"group:food_peas"},
		{"group:food_bowl"}
	}
})
]]--
