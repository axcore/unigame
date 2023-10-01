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
minetest.register_craftitem("farming:rice_flour", {
	description = S("Rice Flour"),
	inventory_image = "farming_rice_flour.png",
	groups = {food_rice_flour = 1, flammable = 1}
})
minetest.register_craft({
	output = "farming:rice_flour",
	recipe = {
		{"farming:rice", "farming:rice", "farming:rice"},
		{"farming:rice", "farming:mortar_pestle", ""}
	},
	replacements = {{"group:food_mortar_pestle", "farming:mortar_pestle"}}
})
]]--
