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
minetest.register_craftitem("farming:porridge", {
	description = S("Porridge"),
	inventory_image = "farming_porridge.png",
	on_use = minetest.item_eat(6, "farming:bowl")
})
minetest.register_craft({
--	type = "shapeless",
	output = "farming:porridge",
	recipe = {
		{"group:food_oats", "group:food_oats", "group:food_oats"},
		{"group:food_oats", "group:food_bowl", "group:food_milk_glass"}
	},
	replacements = {
		{"mobs:glass_milk", "vessels:drinking_glass"},
		{"farming:soy_milk", "vessels:drinking_glass"}
	}
})
]]--
