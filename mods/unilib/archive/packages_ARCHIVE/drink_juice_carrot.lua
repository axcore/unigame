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
minetest.register_craftitem("farming:carrot_juice", {
	description = S("Carrot Juice"),
	inventory_image = "farming_carrot_juice.png",
	on_use = minetest.item_eat(4, "vessels:drinking_glass"),
	groups = {vessel = 1, drink = 1}
})
minetest.register_craft({
	output = "farming:carrot_juice",
	recipe = {
		{"group:food_carrot"},
		{"farming:juicer"},
		{"vessels:drinking_glass"}
	},
	replacements = {
		{"group:food_juicer", "farming:juicer"}
	}
})
]]--
