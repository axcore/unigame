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
minetest.register_craftitem("cropocalypse:cocao_paste", {
	description = ("Cocao Paste"),
	inventory_image = "cropocalypse_cocao_paste.png",
	on_use = minetest.item_eat(2),
	groups = {food_cocao_paste = 1, flammable = 1},
})
minetest.register_craft({
	type = "shapeless",
	output = "cropocalypse:cocao_paste",
	recipe = {"cropocalypse:roasted_cocao", "cropocalypse:sugar", "cropocalypse:sugar"}
})
]]--
