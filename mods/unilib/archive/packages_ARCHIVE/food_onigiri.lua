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
minetest.register_craftitem("farming:onigiri", {
	description = S("Onirigi"),
	inventory_image = "farming_onigiri.png",
	on_use = minetest.item_eat(2),
	groups = {flammable = 2}
})
minetest.register_craft({
	output = "farming:onigiri",
	recipe = {
		{"group:food_rice", "group:food_salt", "group:food_rice"},
		{"", "group:food_seaweed", ""}
	}
})
]]--
