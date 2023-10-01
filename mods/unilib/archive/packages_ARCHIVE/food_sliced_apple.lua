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
minetest.register_craftitem("cropocalypse:sliced_apples", {
	description = ("Sliced Apples"),
	inventory_image = "cropocalypse_sliced_apples.png",
	on_use = minetest.item_eat(2),
	groups = {food_sliced_apples = 1, flammable = 1},
})
minetest.register_craft({
	type = "shapeless",
	output = "cropocalypse:sliced_apples 4",
	recipe = {"default:apple", "default:apple", "default:apple"}
})
]]--
