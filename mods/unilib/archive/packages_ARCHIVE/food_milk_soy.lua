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
minetest.register_node("farming:soy_milk", {
	description = S("Soy Milk"),
	drawtype = "plantlike",
	tiles = {"farming_soy_milk_glass.png"},
	inventory_image = "farming_soy_milk_glass.png",
	wield_image = "farming_soy_milk_glass.png",
	paramtype = "light",
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3}
	},
	on_use = minetest.item_eat(2, "vessels:drinking_glass"),
	groups = {
		vessel = 1, food_milk_glass = 1, dig_immediate = 3,
		attached_node = 1, drink = 1
	},
	sounds = default.node_sound_glass_defaults()
})
minetest.register_craft( {
	output = "farming:soy_milk",
	recipe = {
		{"group:food_soy", "group:food_soy", "group:food_soy"},
		{"farming:vanilla_extract", "bucket:bucket_water", "vessels:drinking_glass"}
	},
	replacements = {
		{"bucket:bucket_water", "bucket:bucket_empty"},
		{"farming:vanilla_extract", "vessels:glass_bottle"}
	}
})
]]--
