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
minetest.register_node("farming:coffee_cup", {
	description = S("Cup of Coffee"),
	drawtype = "torchlike",
	tiles = {"farming_coffee_cup.png"},
	inventory_image = "farming_coffee_cup.png",
	wield_image = "farming_coffee_cup.png",
	paramtype = "light",
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.25, 0.25}
	},
	groups = {vessel = 1, dig_immediate = 3, attached_node = 1, drink = 1},
	on_use = minetest.item_eat(2, "vessels:drinking_glass"),
	sounds = default.node_sound_glass_defaults()
})
minetest.register_alias("farming:coffee_cup_hot", "farming:coffee_cup")
minetest.register_alias("farming:drinking_cup", "vessels:drinking_glass")
minetest.register_craft( {
	output = "farming:coffee_cup",
	recipe = {
		{"group:food_saucepan", "group:food_coffee", "group:water_bucket"},
		{"", "vessels:drinking_glass", ""}
	},
	replacements = {
		{"group:water_bucket", "bucket:bucket_empty"},
		{"group:food_saucepan", "farming:saucepan"}
	}
})
if minetest.get_modpath("bucket_wooden") then
	minetest.register_craft( {
		output = "farming:coffee_cup",
		recipe = {
			{"group:food_saucepan", "group:food_coffee", "group:water_bucket_wooden"},
			{"", "vessels:drinking_glass", ""}
		},
		replacements = {
			{"group:water_bucket_wooden", "bucket_wooden:bucket_empty"},
			{"group:food_saucepan", "farming:saucepan"}
		}
	})
end
]]--
