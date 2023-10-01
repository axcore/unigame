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
minetest.register_craftitem("farming:soy_beans", {
	description = S("Soy Beans"),
	inventory_image = "farming_soy_beans.png",
	groups = {food_soy = 1, flammable = 2},
	on_use = minetest.item_eat(1)
})
minetest.register_craft({
	output = "farming:soy_beans",
	recipe = {{"farming:soy_pod"}}
})
]]--
