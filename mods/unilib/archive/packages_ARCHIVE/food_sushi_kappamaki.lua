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
minetest.register_craftitem("ethereal:sushi_kappamaki", {
	description = S("Kappa Maki Sushi"),
	inventory_image = "ethereal_sushi_kappa_maki.png",
	on_use = minetest.item_eat(3)
})
minetest.register_craft({
	output = "ethereal:sushi_kappamaki 2",
	recipe = {
		{"group:food_seaweed", "group:food_cucumber", "group:food_rice"}
	}
})
]]--
