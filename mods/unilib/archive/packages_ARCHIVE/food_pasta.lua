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
minetest.register_craftitem("farming:pasta", {
	description = S("Pasta"),
	inventory_image = "farming_pasta.png",
	groups = {food_pasta = 1}
})
minetest.register_craft({
	output = "farming:pasta",
	recipe = {
		{"group:food_flour", "group:food_butter", "group:food_mixing_bowl"}
	},
	replacements = {{"group:food_mixing_bowl", "farming:mixing_bowl"}}
})
minetest.register_craft({
	output = "farming:pasta",
	recipe = {
		{"group:food_flour", "group:food_oil", "group:food_mixing_bowl"}
	},
	replacements = {
		{"group:food_mixing_bowl", "farming:mixing_bowl"},
		{"group:food_oil", "vessels:glass_bottle"}
	}
})
]]--
