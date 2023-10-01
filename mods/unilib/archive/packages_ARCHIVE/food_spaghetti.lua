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
minetest.register_craftitem("farming:spaghetti", {
	description = S("Spaghetti"),
	inventory_image = "farming_spaghetti.png",
	on_use = minetest.item_eat(8)
})
minetest.register_craft({
	output = "farming:spaghetti",
	recipe = {
		{"group:food_pasta", "group:food_saucepan", "group:food_tomato"},
		{"group:food_garlic_clove", "group:food_garlic_clove", ""}
	},
	replacements = {{"group:food_saucepan", "farming:saucepan"}}
})
]]--
