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
minetest.register_craftitem("farming:cornstarch", {
	description = S("Cornstarch"),
	inventory_image = "farming_cornstarch.png",
	groups = {food_cornstarch = 1, food_gelatin = 1, food_flammable = 2}
})
minetest.register_craft({
	output = "farming:cornstarch",
	recipe = {
		{"group:food_mortar_pestle", "group:food_corn_cooked", "group:food_baking_tray"},
		{"", "group:food_bowl", ""},
	},
	replacements = {
		{"group:food_mortar_pestle", "farming:mortar_pestle"},
		{"group:food_baking_tray", "farming:baking_tray"}
	}
})
]]--
