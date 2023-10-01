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
minetest.register_craftitem("farming:potato_omelet", {
	description = S("Potato omelet"),
	inventory_image = "farming_potato_omelet.png",
	on_use = minetest.item_eat(6, "farming:bowl")
})
minetest.register_craft({
	type = "shapeless",
	output = "farming:potato_omelet",
	recipe = {
		"group:food_egg", "farming:potato", "group:food_onion",
		"group:food_skillet", "group:food_bowl"},
	replacements = {{"group:food_skillet", "farming:skillet"}}
})
]]--
