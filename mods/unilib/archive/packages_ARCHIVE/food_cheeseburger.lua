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
minetest.register_craftitem("farming:burger", {
	description = S("Burger"),
	inventory_image = "farming_burger.png",
	on_use = minetest.item_eat(16),
})
minetest.register_craft({
	output = "farming:burger",
	recipe = {
		{"farming:bread", "group:food_meat", "group:food_cheese"},
		{"group:food_tomato", "group:food_cucumber", "group:food_onion"},
		{"group:food_lettuce", "", ""}
	}
})
]]--
