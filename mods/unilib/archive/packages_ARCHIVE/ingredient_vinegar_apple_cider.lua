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
minetest.register_craftitem("cropocalypse:apple_cider_vinegar", {
	description = ("Apple Cider Vinegar"),
	inventory_image = "cropocalypse_apple_cider_vinegar.png",
	on_use = minetest.item_eat(1),
	groups = {food_apple_cider_vinegar = 1, flammable = 1},
})
minetest.register_craft({
	type = "shapeless",
	output = "cropocalypse:apple_cider_vinegar",
	recipe = {"cropocalypse:sliced_apples", "cropocalypse:sliced_apples", "cropocalypse:sugar", "vessels:glass_bottle"}
})
]]--
