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
minetest.register_craftitem("cropocalypse:sugar", {
	description = ("Sugar"),
	inventory_image = "cropocalypse_sugar.png",
	on_use = minetest.item_eat(1),
	groups = {food_sugar = 1, flammable = 1},
})
minetest.register_craft({
	type = "shapeless",
	output = "cropocalypse:sugar 2",
	recipe = {"cropocalypse:beet", "cropocalypse:beet", "cropocalypse:beet"}
})
]]--
