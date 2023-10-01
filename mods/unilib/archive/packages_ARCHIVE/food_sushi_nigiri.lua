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
minetest.register_craftitem("ethereal:sushi_nigiri", {
	description = S("Nigiri Sushi"),
	inventory_image = "ethereal_sushi_nigiri.png",
	on_use = minetest.item_eat(2)
})
minetest.register_craft({
	output = "ethereal:sushi_nigiri 2",
	recipe = {
		{"group:food_rice", "group:food_fish_raw", ""}
	}
})
]]--
