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
minetest.register_craftitem("farming:peas", {
	description = S("Peas"),
	inventory_image = "farming_pea_peas.png",
	groups = {food_peas = 1, flammable = 2},
	on_use = minetest.item_eat(1)
})
minetest.register_craft({
	output = "farming:peas",
	recipe = {{"farming:pea_pod"}}
})
]]--
