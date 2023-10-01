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
minetest.register_craftitem("farming:mochi", {
	description = S("Mochi"),
	inventory_image = "farming_mochi.png",
	on_use = minetest.item_eat(3),
	groups = {flammable = 2}
})
minetest.register_craft({
	output = "farming:mochi",
	recipe = {
		{"group:food_rice", "group:food_sugar", "group:food_rice"},
		{"", "group:food_mortar_pestle", ""},
		{"", "farming:glass_water", ""}
	},
	replacements = {
		{"group:food_mortar_pestle", "farming:mortar_pestle"},
		{"farming:glass_water", "vessels:drinking_glass"}
	}
})
]]--
