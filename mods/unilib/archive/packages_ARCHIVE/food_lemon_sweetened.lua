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
minetest.register_craftitem("ethereal:candied_lemon", {
	description = S("Candied Lemon"),
	inventory_image = "ethereal_candied_lemon.png",
	wield_image = "ethereal_candied_lemon.png",
	groups = {food_candied_lemon = 1},
	on_use = minetest.item_eat(5)
})
minetest.register_craft({
	output = "ethereal:candied_lemon",
	recipe = {
		{"farming:baking_tray", "ethereal:lemon", "group:food_sugar"}
	},
	replacements = {
		{"farming:baking_tray", "farming:baking_tray"}
	}
})
]]--
