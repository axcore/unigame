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
minetest.register_node("farming:bottle_ethanol", {
	description = S("Bottle of Ethanol"),
	drawtype = "plantlike",
	tiles = {"farming_bottle_ethanol.png"},
	inventory_image = "farming_bottle_ethanol.png",
	wield_image = "farming_bottle_ethanol.png",
	paramtype = "light",
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
	},
	groups = {vessel = 1, dig_immediate = 3, attached_node = 1},
	sounds = default.node_sound_glass_defaults()
})
minetest.register_craft( {
	output = "farming:bottle_ethanol",
	recipe = {
		{"group:food_corn", "group:food_corn", "group:food_corn"},
		{"group:food_corn", "vessels:glass_bottle", "group:food_corn"},
		{"group:food_corn", "group:food_corn", "group:food_corn"}
	}
})
minetest.register_craft({
	type = "fuel",
	recipe = "farming:bottle_ethanol",
	burntime = 80,
	replacements = {{"farming:bottle_ethanol", "vessels:glass_bottle"}}
})
]]--
