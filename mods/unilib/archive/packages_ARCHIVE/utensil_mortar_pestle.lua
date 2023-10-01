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
minetest.register_craftitem("farming:mortar_pestle", {
	description = S("Mortar and Pestle"),
	inventory_image = "farming_mortar_pestle.png",
	groups = {food_mortar_pestle = 1, flammable = 2}
})
minetest.register_craft({
	output = "farming:mortar_pestle",
	recipe = {
		{"default:stone", "group:stick", "default:stone"},
		{"", "default:stone", ""}
	}
})
]]--
