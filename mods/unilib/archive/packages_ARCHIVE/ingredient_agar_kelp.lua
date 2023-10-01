---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_craftitem("cropocalypse:kelp_agar", {
	description = ("Kelp Agar"),
	inventory_image = "cropocalypse_kelp_agar.png",
	on_use = minetest.item_eat(1),
	groups = {food_kelp_agar = 1, flammable = 1},
})
minetest.register_craft({
	type = "cooking",
	output = "cropocalypse:kelp_agar",
	recipe = "cropocalypse:saltwater_kelp_jar",
})
]]--
