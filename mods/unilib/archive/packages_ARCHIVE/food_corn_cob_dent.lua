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
minetest.register_craftitem("cropocalypse:corn_on_the_cob", {
	description = ("Corn On The Cob"),
	inventory_image = "cropocalypse_corn_on_the_cob.png",
	on_use = minetest.item_eat(4),
	groups = {food_corn_on_the_cob = 1, flammable = 1},
})
minetest.register_craft({
	type = "cooking",
	output = "cropocalypse:corn_on_the_cob",
	recipe = "cropocalypse:corn",
})
]]--
