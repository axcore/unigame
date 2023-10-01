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
minetest.register_craftitem("farming:potato_salad", {
	description = S("Cucumber and Potato Salad"),
	inventory_image = "farming_potato_salad.png",
	on_use = minetest.item_eat(10, "farming:bowl")
})
minetest.register_craft({
	output = "farming:potato_salad",
	recipe = {
		{"group:food_cucumber"},
		{"farming:baked_potato"},
		{"group:food_bowl"}
	}
})
]]--
