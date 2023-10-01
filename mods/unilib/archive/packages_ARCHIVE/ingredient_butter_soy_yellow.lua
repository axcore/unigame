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
minetest.register_craftitem("cropocalypse:soy_butter", {
	description = ("Soy Butter"),
	inventory_image = "cropocalypse_soy_butter.png",
	on_use = minetest.item_eat(4),
	groups = {food_soy_butter = 1, flammable = 1},
})
minetest.register_craft({
	type = "shapeless",
	output = "cropocalypse:soy_butter",
	recipe = {"cropocalypse:wooden_bowl", "cropocalypse:soy_milk", "cropocalypse:apple_cider_vinegar", "cropocalypse:kelp_agar"}
})
]]--
