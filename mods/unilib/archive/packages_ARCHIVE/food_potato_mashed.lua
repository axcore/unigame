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
minetest.register_craftitem("cropocalypse:mashed_potatoes", {
	description = ("Mashed Potatoes"),
	inventory_image = "cropocalypse_mashed_potatoes.png",
	on_use = minetest.item_eat(4),
	groups = {food_mashed_potatoes = 1, flammable = 1},
})
minetest.register_craft({
	type = "shapeless",
	output = "cropocalypse:mashed_potatoes",
	recipe = {"cropocalypse:wooden_bowl", "cropocalypse:potato", "cropocalypse:potato", "cropocalypse:potato"}
})
]]--
