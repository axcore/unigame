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
minetest.register_craftitem("farming:smoothie_berry", {
	description = S("Triple Berry Smoothie"),
	inventory_image = "farming_berry_smoothie.png",
	on_use = minetest.item_eat(6, "vessels:drinking_glass"),
	groups = {vessel = 1, drink = 1}
})
minetest.register_craft({
	output = "farming:smoothie_berry",
	type = "shapeless",
	recipe = {
		"group:food_raspberries", "group:food_blackberries",
		"group:food_strawberry", "group:food_banana",
		"vessels:drinking_glass"
	}
})
]]--
