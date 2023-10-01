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
minetest.register_craftitem("farming:spanish_potatoes", {
	description = S("Spanish Potatoes"),
	inventory_image = "farming_spanish_potatoes.png",
	on_use = minetest.item_eat(8, "farming:bowl"),
})
minetest.register_craft({
	type = "shapeless",
	output = "farming:spanish_potatoes",
	recipe = {
		"farming:potato", "group:food_parsley", "farming:potato",
		"group:food_egg", "group:food_flour", "farming:onion",
		"farming:garlic_clove", "group:food_bowl", "group:food_skillet"
	},
	replacements = {{"group:food_skillet", "farming:skillet"}}
})
]]--
