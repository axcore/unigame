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
minetest.register_craftitem("farming:apple_pie", {
	description = S("Apple Pie"),
	inventory_image = "farming_apple_pie.png",
	on_use = minetest.item_eat(6)
})
minetest.register_craft({
	output = "farming:apple_pie",
	recipe = {
		{"group:food_flour", "group:food_sugar", "group:food_apple"},
		{"", "group:food_baking_tray", ""}
	},
	replacements = {{"group:food_baking_tray", "farming:baking_tray"}}
})
]]--
