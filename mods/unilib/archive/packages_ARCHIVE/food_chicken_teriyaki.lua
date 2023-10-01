---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_craftitem("ethereal:teriyaki_chicken", {
	description = S("Teriyaki Chicken"),
	inventory_image = "ethereal_teriyaki_chicken.png",
	on_use = minetest.item_eat(4)
})
minetest.register_craft({
	output = "ethereal:teriyaki_chicken 2",
	recipe = {
		{"group:food_chicken_raw", "group:food_sugar", "group:food_soy_sauce"},
		{"group:food_garlic_clove", "group:food_saucepan", "group:food_gelatin"}
	},
	replacements = {
		{"group:food_soy_sauce", "vessels:glass_bottle"},
		{"group:food_saucepan", "farming:saucepan"}
	}
})
]]--
