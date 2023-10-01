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
minetest.register_node("farming:soy_sauce", {
	description = S("Soy Sauce"),
	drawtype = "plantlike",
	tiles = {"farming_soy_sauce.png"},
	inventory_image = "farming_soy_sauce.png",
	wield_image = "farming_soy_sauce.png",
	paramtype = "light",
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3}
	},
	groups = {
		vessel = 1, food_soy_sauce = 1, dig_immediate = 3, attached_node = 1
	},
	sounds = default.node_sound_glass_defaults()
})
minetest.register_craft( {
	output = "farming:soy_sauce",
	recipe = {
		{"group:food_soy", "group:food_salt", "group:food_soy"},
		{"", "group:food_juicer", ""},
		{"", "bucket:bucket_water", "vessels:glass_bottle"}
	},
	replacements = {
		{"bucket:bucket_water", "bucket:bucket_empty"},
		{"group:food_juicer", "farming:juicer"}
	}
})
]]--
