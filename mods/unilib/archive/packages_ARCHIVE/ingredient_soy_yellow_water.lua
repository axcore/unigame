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
minetest.register_craftitem("cropocalypse:soybean_water", {
	description = ("Soybean Water"),
	inventory_image = "cropocalypse_soybean_water.png",
	on_use = minetest.item_eat(1),
	groups = {food_soybean_water = 1, flammable = 1},
})

minetest.register_craft({
	type = "shapeless",
	output = "cropocalypse:soybean_water",
	recipe = {"cropocalypse:soybean", "cropocalypse:soybean", "cropocalypse:soybean", "vessels:glass_bottle"}
})
]]--
