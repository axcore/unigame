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
minetest.register_craftitem("ethereal:banana_bread", {
	description = S("Banana Loaf"),
	inventory_image = "ethereal_banana_bread.png",
	wield_image = "ethereal_banana_bread.png",
	groups = {food_bread = 1, flammable = 3},
	on_use = minetest.item_eat(6)
})
minetest.register_craft({
	type = "cooking",
	cooktime = 14,
	output = "ethereal:banana_bread",
	recipe = "ethereal:banana_dough"
})
]]--
