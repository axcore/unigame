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
minetest.register_craftitem("ethereal:sashimi", {
	description = S("Sashimi"),
	inventory_image = "ethereal_sashimi.png",
	wield_image = "ethereal_sashimi.png",
	on_use = minetest.item_eat(4)
})
minetest.register_craft({
	output = "ethereal:sashimi 2",
	recipe = {
		{"group:food_seaweed", "group:food_fish_raw", "group:food_seaweed"},
	}
})
]]--
