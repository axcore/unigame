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
minetest.register_craftitem("cropocalypse:linen", {
	description = ("Linen"),
	inventory_image = "cropocalypse_linen.png",
	groups = {linen = 1, flammable = 1, thread = 1},
})
minetest.register_craft({
	output = "cropocalypse:linen 1",
	recipe = {
		{"farming:string", "farming:string"},
		{"farming:string", "farming:string"}
	}
})
minetest.register_craft({
	type = "shapeless",
	output = "wool:white 1",
	recipe = {"cropocalypse:linen", "cropocalypse:linen", "cropocalypse:linen"}
})
]]--
