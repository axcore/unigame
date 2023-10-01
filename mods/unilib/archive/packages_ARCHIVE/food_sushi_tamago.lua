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
minetest.register_craftitem("ethereal:sushi_tamago", {
	description = S("Tamago Sushi"),
	inventory_image = "ethereal_sushi_tamago.png",
	on_use = minetest.item_eat(2)
})
minetest.register_craft({
	output = "ethereal:sushi_tamago 2",
	recipe = {
		{"group:food_seaweed", "group:food_egg", "group:food_rice"}
	}
})
]]--
