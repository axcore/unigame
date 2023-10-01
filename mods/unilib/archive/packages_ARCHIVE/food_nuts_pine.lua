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
minetest.register_craftitem("ethereal:pine_nuts", {
	description = S("Pine Nuts"),
	inventory_image = "ethereal_pine_nuts.png",
	wield_image = "ethereal_pine_nuts.png",
	groups = {food_pine_nuts = 1, flammable = 2},
	on_use = minetest.item_eat(1)
})
]]--
