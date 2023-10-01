---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bakedeye
-- Code:    MIT
-- Media:   unknown
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_craftitem("bakedeye:food", {
	description = "Baked Eye",
	inventory_image = "bakedeye_food.png",
	on_use = minetest.item_eat(3),
})

minetest.register_craft({
	type = "cooking",
	output = "bakedeye:food",
	recipe = "underch:blackeye_item",
})

minetest.register_craft({
	type = "cooking",
	output = "bakedeye:food",
	recipe = "underch:greeneye_item",
})

minetest.register_craft({
	type = "cooking",
	output = "bakedeye:food",
	recipe = "underch:redeye_item",
})

minetest.register_craft({
	type = "cooking",
	output = "bakedeye:food",
	recipe = "underch:purpleeye_item",
})
]]--
