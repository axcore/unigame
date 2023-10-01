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
minetest.register_craftitem("ethereal:olive_oil", {
	description = S("Olive Oil"),
	inventory_image = "ethereal_olive_oil.png",
	wield_image = "ethereal_olive_oil.png",
	groups = {food_oil = 1, food_olive_oil = 1, vessel = 1}
})
minetest.register_craft({
	output = "ethereal:olive_oil",
	recipe = {
		{"ethereal:olive", "ethereal:olive", "ethereal:olive"},
		{"ethereal:olive", "ethereal:olive", "ethereal:olive"},
		{"farming:juicer", "vessels:glass_bottle", ""}
	},
	replacements = {
		{"farming:juicer", "farming:juicer"}
	}
})
]]--
