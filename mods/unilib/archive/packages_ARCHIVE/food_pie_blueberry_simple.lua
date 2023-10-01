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
minetest.register_craftitem("farming:blueberry_pie", {
	description = S("Blueberry Pie"),
	inventory_image = "farming_blueberry_pie.png",
	on_use = minetest.item_eat(6)
})
minetest.register_craft({
	output = "farming:blueberry_pie",
	recipe = {
		{"group:food_flour", "group:food_sugar", "group:food_blueberries"},
		{"group:food_baking_tray", "", ""}
	},
	replacements = {{"group:food_baking_tray", "farming:baking_tray"}}
})
]]--
