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
minetest.register_craftitem("ethereal:teriyaki_beef", {
	description = S("Teriyaki Beef"),
	inventory_image = "ethereal_teriyaki_beef.png",
	on_use = minetest.item_eat(12, "ethereal:bowl")
})
minetest.register_craft({
	output = "ethereal:teriyaki_beef",
	recipe = {
		{"group:food_meat_raw", "group:food_sugar", "group:food_soy_sauce"},
		{"group:food_garlic_clove", "group:food_saucepan", "group:food_gelatin"},
		{"group:food_cabbage", "group:food_rice", "group:food_bowl"}
	},
	replacements = {
		{"group:food_soy_sauce", "vessels:glass_bottle"},
		{"group:food_saucepan", "farming:saucepan"}
	}
})
]]--
