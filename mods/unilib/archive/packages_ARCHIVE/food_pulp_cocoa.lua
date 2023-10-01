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
minetest.register_craftitem("cropocalypse:cocao_pulp", {
	description = ("Cocao Pulp"),
	inventory_image = "cropocalypse_cocao_pulp.png",
	on_use = minetest.item_eat(1),
	groups = {food_cocao_pulp = 1, flammable = 1},
})
minetest.register_craft({
	type = "shapeless",
	output = "cropocalypse:cocao_pulp",
	recipe = {"cropocalypse:wooden_bowl", "cropocalypse:cocao", "cropocalypse:cocao", "cropocalypse:cocao"}
})
]]--
