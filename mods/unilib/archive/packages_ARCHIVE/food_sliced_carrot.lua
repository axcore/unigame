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
minetest.register_craftitem("cropocalypse:sliced_carrots", {
	description = ("Sliced Carrots"),
	inventory_image = "cropocalypse_sliced_carrots.png",
	on_use = minetest.item_eat(2),
	groups = {food_sliced_carrots = 1, flammable = 1},
})
minetest.register_craft({
	type = "shapeless",
	output = "cropocalypse:sliced_carrots 2",
	recipe = {"cropocalypse:carrot", "cropocalypse:carrot", "cropocalypse:carrot"}
})
]]--
