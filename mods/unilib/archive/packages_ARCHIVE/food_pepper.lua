---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
-- green pepper
minetest.register_craftitem("farming:pepper", {
	description = S("Green Pepper"),
	inventory_image = "crops_pepper.png",
	on_use = minetest.item_eat(2),
	groups = {food_pepper = 1, flammable = 3}
})

-- red pepper
minetest.register_craftitem("farming:pepper_red", {
	description = S("Red Pepper"),
	inventory_image = "crops_pepper_red.png",
	on_use = minetest.item_eat(4),
	groups = {food_pepper = 1, flammable = 3}
})

-- yellow pepper
minetest.register_craftitem("farming:pepper_yellow", {
	description = S("Yellow Pepper"),
	inventory_image = "crops_pepper_yellow.png",
	on_use = minetest.item_eat(3),
	groups = {food_pepper = 1, flammable = 3}
})
]]--
