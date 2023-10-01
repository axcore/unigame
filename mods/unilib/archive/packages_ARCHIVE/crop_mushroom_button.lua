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
farming.register_plant("cropocalypse:button_mushroom", {
	description = ("Button Mushroom Spore"),
	harvest_description = ("Button Mushroom"),
	paramtype2 = "meshoptions",
	inventory_image = "cropocalypse_button_mushroom_seed.png",
	steps = 8,
	minlight = 0,
	maxlight = default.LIGHT_MAX,
	fertility = {"grassland", "desert"},
	groups = {food_button_mushroom = 1, flammable = 4},
	place_param2 = 3,
})

minetest.register_craftitem("cropocalypse:button_mushroom", {
	description = ("Button Mushroom"),
	inventory_image = "cropocalypse_button_mushroom.png",
	wield_image = "cropocalypse_button_mushroom.png",
	paramtype = "meshoptions",
	groups = {food_button_mushroom = 1, flammable = 4},
	on_use = minetest.item_eat(1),
})
]]--
