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
minetest.register_craftitem("farming:flour_multigrain", {
	description = S("Multigrain Flour"),
	inventory_image = "farming_flour_multigrain.png",
	groups = {food_flour = 1, flammable = 1},
})
minetest.register_craft({
	type = "shapeless",
	output = "farming:flour_multigrain",
	recipe = {
		"farming:wheat", "farming:barley", "farming:oat",
		"farming:rye", "farming:mortar_pestle"
	},
	replacements = {{"group:food_mortar_pestle", "farming:mortar_pestle"}}
})
]]--
