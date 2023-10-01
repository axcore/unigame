---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cucina_vegana
-- Code:    LGPL3.0
-- Media:   LGPL3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("cucina_vegana:fish_parsley_rosemary", {
	description = S("Fish on Parsley and Rosemary (raw)"),
	drawtype = "plantlike",
	tiles = {"cucina_vegana_fish_parsley_rosemary.png"},
	inventory_image = "cucina_vegana_fish_parsley_rosemary.png",
	wield_image = "cucina_vegana_fish_parsley_rosemary.png",
	paramtype = "light",
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
	},
	groups = {dig_immediate = 3, attached_node = 1},
	sounds = default.node_sound_glass_defaults(),
})
minetest.register_craft({
	output = "cucina_vegana:fish_parsley_rosemary",
	recipe = {
				{"cucina_vegana:parsley","group:food_oil", "cucina_vegana:rosemary"},
				{"","group:food_fish", ""},
				{"","group:food_plate", ""},
			},
			replacements = {
							{"group:food_oil", "vessels:glass_bottle"},
						}
})

minetest.register_node("cucina_vegana:fish_parsley_rosemary_cooked", {
	description = S("Fish on Parsley and Rosemary"),
	drawtype = "plantlike",
	tiles = {"cucina_vegana_fish_parsley_rosemary_cooked.png"},
	inventory_image = "cucina_vegana_fish_parsley_rosemary_cooked.png",
	wield_image = "cucina_vegana_fish_parsley_rosemary_cooked.png",
	paramtype = "light",
	is_ground_content = false,
	walkable = false,
	on_use = minetest.item_eat(6,  "cucina_vegana:plate"),
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
	},
	groups = {dig_immediate = 3, attached_node = 1, eatable = 1},
	sounds = default.node_sound_glass_defaults(),
})
minetest.register_craft({
	type = "cooking",
	cooktime = 18,
	output = "cucina_vegana:fish_parsley_rosemary_cooked",
	recipe = "cucina_vegana:fish_parsley_rosemary"
})
]]--
