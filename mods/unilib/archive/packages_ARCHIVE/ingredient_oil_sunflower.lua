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
minetest.register_node("farming:sunflower_oil", {
	description = S("Bottle of Sunflower Oil"),
	drawtype = "plantlike",
	tiles = {"farming_sunflower_oil.png"},
	inventory_image = "farming_sunflower_oil.png",
	wield_image = "farming_sunflower_oil.png",
	paramtype = "light",
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
	},
	groups = {
		food_oil = 1, vessel = 1, dig_immediate = 3, attached_node = 1,
		flammable = 2
	},
	sounds = default.node_sound_glass_defaults()
})
minetest.register_craft( {
	output = "farming:sunflower_oil",
	recipe = {
		{"group:food_sunflower_seeds", "group:food_sunflower_seeds", "group:food_sunflower_seeds"},
		{"group:food_sunflower_seeds", "group:food_sunflower_seeds", "group:food_sunflower_seeds"},
		{"group:food_sunflower_seeds", "vessels:glass_bottle", "group:food_sunflower_seeds"}
	}
})
minetest.register_craft({
	type = "fuel",
	recipe = "farming:sunflower_oil",
	burntime = 30,
	replacements = {{"farming:sunflower_oil", "vessels:glass_bottle"}}
})
]]--
