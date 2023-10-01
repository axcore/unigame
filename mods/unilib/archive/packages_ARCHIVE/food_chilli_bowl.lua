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
minetest.register_craftitem("farming:chili_bowl", {
	description = S("Bowl of Chili"),
	inventory_image = "farming_chili_bowl.png",
	on_use = minetest.item_eat(8, "farming:bowl")
})
minetest.register_craft({
	output = "farming:chili_bowl",
	recipe = {
		{"group:food_chili_pepper", "group:food_rice", "group:food_tomato"},
		{"group:food_beans", "group:food_bowl", ""}
	}
})
]]--
