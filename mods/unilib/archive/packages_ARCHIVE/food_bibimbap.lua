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
minetest.register_craftitem("farming:bibimbap", {
	description = S("Bibimbap"),
	inventory_image = "farming_bibimbap.png",
	on_use = minetest.item_eat(8, "farming:bowl")
})
minetest.register_craft({
	output = "farming:bibimbap",
	recipe = {
		{"group:food_skillet", "group:food_bowl", "group:food_egg"},
		{"group:food_rice", "group:food_chicken_raw", "group:food_cabbage"},
		{"group:food_carrot", "group:food_chili_pepper", ""}
	},
	replacements = {{"group:food_skillet", "farming:skillet"}}
})
minetest.register_craft({
	output = "farming:bibimbap",
	type = "shapeless",
	recipe = {
		"group:food_skillet", "group:food_bowl", "group:food_mushroom",
		"group:food_rice", "group:food_cabbage", "group:food_carrot",
		"group:food_mushroom", "group:food_chili_pepper"
	},
	replacements = {{"group:food_skillet", "farming:skillet"}}
})
]]--
