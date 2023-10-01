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
minetest.register_node("farming:hemp_oil", {
	description = S("Bottle of Hemp Oil"),
	drawtype = "plantlike",
	tiles = {"farming_hemp_oil.png"},
	inventory_image = "farming_hemp_oil.png",
	wield_image = "farming_hemp_oil.png",
	paramtype = "light",
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
	},
	groups = {food_oil = 1, vessel = 1, dig_immediate = 3, attached_node = 1},
	sounds = default.node_sound_glass_defaults()
})
minetest.register_craft( {
	output = "farming:hemp_oil",
	recipe = {
		{"farming:hemp_leaf", "farming:hemp_leaf", "farming:hemp_leaf"},
		{"farming:hemp_leaf", "farming:hemp_leaf", "farming:hemp_leaf"},
		{"", "vessels:glass_bottle", ""}
	}
})
minetest.register_craft( {
	output = "farming:hemp_oil",
	recipe = {
		{"farming:seed_hemp", "farming:seed_hemp", "farming:seed_hemp"},
		{"farming:seed_hemp", "farming:seed_hemp", "farming:seed_hemp"},
		{"farming:seed_hemp", "vessels:glass_bottle", "farming:seed_hemp"}
	}
})
minetest.register_craft({
	type = "fuel",
	recipe = "farming:hemp_oil",
	burntime = 20,
	replacements = {{"farming:hemp_oil", "vessels:glass_bottle"}}
})
]]--
