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
minetest.register_craftitem("cropocalypse:chocolate", {
	description = ("Chocolate"),
	inventory_image = "cropocalypse_chocolate.png",
	on_use = minetest.item_eat(4),
	groups = {food_chocolate = 1, flammable = 1},
})
minetest.register_craft({
	type = "cooking",
	output = "cropocalypse:chocolate",
	recipe = "cropocalypse:cocao_paste",
})
]]--
