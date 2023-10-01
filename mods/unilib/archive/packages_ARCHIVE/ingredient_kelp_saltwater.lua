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
minetest.register_craftitem("cropocalypse:saltwater_kelp_jar", {
	description = ("Saltwater Kelp Jar"),
	inventory_image = "cropocalypse_saltwater_kelp_jar.png",
	on_use = minetest.item_eat(1),
	groups = {food_saltwater_kelp_jar = 1, flammable = 1},
})
minetest.register_craft({
	type = "shapeless",
	output = "cropocalypse:saltwater_kelp_jar",
	recipe = {"default:sand_with_kelp", "default:sand_with_kelp", "default:sand_with_kelp", "vessels:glass_bottle"}
})

minetest.register_craft({
	type = "shapeless",
	output = "cropocalypse:saltwater_kelp_jar 3",
	recipe = {"cropocalypse:saltwater_kelp_jar", "vessels:glass_bottle", "vessels:glass_bottle"}
})
minetest.register_craft({
	type = "shapeless",
	output = "default:sand_with_kelp",
	recipe = {"cropocalypse:saltwater_kelp_jar"}
})
]]--
