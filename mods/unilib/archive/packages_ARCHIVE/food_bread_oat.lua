---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    grains
-- Code:    MIT
-- Media:   CC BY 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_craftitem("grains:oat_bread", {
	description = "Oatbread",
	inventory_image = "grains_oat_bread.png",
	on_use = minetest.item_eat(5),
	groups = {flammable = 2},
})
minetest.register_craft({
	type = "cooking",
	cooktime = 15,
	output = "grains:oat_bread",
	recipe = "grains:oat_flour"
})
minetest.register_craft({
	type = "fuel",
	recipe = "grains:oat_bread",
	burntime = 1,
})
]]--
