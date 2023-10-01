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
minetest.register_craftitem("cropocalypse:roasted_cocao", {
	description = ("Roasted Cocao"),
	inventory_image = "cropocalypse_roasted_cocao.png",
	on_use = minetest.item_eat(2),
	groups = {food_roasted_cocao = 1, flammable = 1},
})
minetest.register_craft({
	type = "cooking",
	output = "cropocalypse:roasted_cocao",
	recipe = "cropocalypse:cocao_pulp",
})
]]--
