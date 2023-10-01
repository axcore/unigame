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
minetest.register_craftitem("farming:pineapple_juice", {
	description = S("Pineapple Juice"),
	inventory_image = "farming_pineapple_juice.png",
	on_use = minetest.item_eat(4, "vessels:drinking_glass"),
	groups = {vessel = 1, drink = 1}
})
minetest.register_craft({
	output = "farming:pineapple_juice",
	recipe = {
		{"group:food_pineapple_ring", "group:food_pineapple_ring",
				"group:food_pineapple_ring"},
		{"", "farming:juicer", ""},
		{"", "vessels:drinking_glass", ""}
	},
	replacements = {
		{"group:food_juicer", "farming:juicer"}
	}
})
minetest.register_craft({
	output = "farming:pineapple_juice 2",
	recipe = {
		{"group:food_pineapple", ""},
		{"farming:juicer", ""},
		{"vessels:drinking_glass", "vessels:drinking_glass"}
	},
	replacements = {
		{"group:food_juicer", "farming:juicer"}
	}
})
]]--
