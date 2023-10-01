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
minetest.register_craftitem("farming:paella", {
	description = S("Paella"),
	inventory_image = "farming_paella.png",
	on_use = minetest.item_eat(8, "farming:bowl")
})
minetest.register_craft({
	type = "shapeless",
	output = "farming:paella",
	recipe = {
		"group:food_rice", "dye:orange", "farming:pepper_red",
		"group:food_peas", "group:food_chicken", "group:food_bowl", "group:food_skillet"
	},
	replacements = {{"group:food_skillet", "farming:skillet"}}
})
]]--
