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
farming.register_plant("cropocalypse:flax", {
	description = ("Flax Seed"),
	harvest_description = ("Flax"),
	inventory_image = "cropocalypse_flax_seed.png",
	steps = 8,
	minlight = 13,
	maxlight = default.LIGHT_MAX,
	fertility = {"grassland", "desert"},
	groups = {crop_flax = 1, flammable = 4},
	place_param2 = 3,
})

minetest.register_craftitem("cropocalypse:flax", {
	description = ("Flax"),
	inventory_image = "cropocalypse_flax.png",
	wield_image = "cropocalypse_flax.png",
	paramtype = "meshoptions",
	groups = {crop_flax = 1, flammable = 4},
})

minetest.register_craft({
	output = "cropocalypse:light_blue_dye 2",
	recipe = {
		{"cropocalypse:flax"}
	}
})
]]--
