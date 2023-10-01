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
minetest.register_craftitem("cropocalypse:mushroom_surprise", {
	description = ("Mushroom Surprise"),
	inventory_image = "cropocalypse_mushroom_surprise.png",
	on_use = minetest.item_eat(6),
	groups = {food_mushroom_surprise = 1, flammable = 1},
})
minetest.register_craft({
	type = "shapeless",
	output = "cropocalypse:mushroom_surprise",
	recipe = {"cropocalypse:wooden_bowl", "cropocalypse:morel_mushroom", "cropocalypse:oyster_mushroom", "cropocalypse:shiitake_mushroom", "cropocalypse:button_mushroom"}
})
]]--
