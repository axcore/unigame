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
minetest.register_craftitem("farming:smoothie_raspberry", {
	description = S("Raspberry Smoothie"),
	inventory_image = "farming_raspberry_smoothie.png",
	on_use = minetest.item_eat(2, "vessels:drinking_glass"),
	groups = {vessel = 1, drink = 1}
})
minetest.register_craft({
	output = "farming:smoothie_raspberry",
	recipe = {
		{"default:snow"},
		{"group:food_raspberries"},
		{"vessels:drinking_glass"}
	}
})
]]--
