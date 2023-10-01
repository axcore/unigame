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
minetest.register_craftitem("farming:rhubarb_pie", {
	description = S("Rhubarb Pie"),
	inventory_image = "farming_rhubarb_pie.png",
	on_use = minetest.item_eat(6)
})
minetest.register_craft({
	output = "farming:rhubarb_pie",
	recipe = {
		{"farming:baking_tray", "group:food_sugar", ""},
		{"group:food_rhubarb", "group:food_rhubarb", "group:food_rhubarb"},
		{"group:food_wheat", "group:food_wheat", "group:food_wheat"}
	},
	replacements = {{"group:food_baking_tray", "farming:baking_tray"}}
})
]]--
