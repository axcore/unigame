---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_craftitem("default:blueberries", {
	description = S("Blueberries"),
	inventory_image = "default_blueberries.png",
	groups = {food_blueberries = 1, food_berry = 1},
	on_use = minetest.item_eat(2),
})
]]--
