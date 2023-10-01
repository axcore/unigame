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
minetest.register_node("farming:vanilla_extract", {
	description = S("Vanilla Extract"),
	drawtype = "plantlike",
	tiles = {"farming_vanilla_extract.png"},
	inventory_image = "farming_vanilla_extract.png",
	wield_image = "farming_vanilla_extract.png",
	paramtype = "light",
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
	},
	groups = {vessel = 1, dig_immediate = 3, attached_node = 1},
	sounds = default.node_sound_glass_defaults(),
})
minetest.register_craft( {
	output = "farming:vanilla_extract",
	recipe = {
		{"group:food_vanilla", "group:food_vanilla", "group:food_vanilla"},
		{"group:food_vanilla", "farming:bottle_ethanol", "bucket:bucket_water"},
	},
	replacements = {
		{"bucket:bucket_water", "bucket:bucket_empty"},
	}
})
minetest.register_craft({
	type = "fuel",
	recipe = "farming:vanilla_extract",
	burntime = 25,
	replacements = {{"farming:vanilla_extract", "vessels:glass_bottle"}}
})
]]--
