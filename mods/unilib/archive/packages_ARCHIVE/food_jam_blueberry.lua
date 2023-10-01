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
minetest.register_node("cucina_vegana:blueberry_jam", {
	description = S("Blueberry Jam"),
	drawtype = "plantlike",
	tiles = {"cucina_vegana_blueberry_jam.png"},
	inventory_image = "cucina_vegana_blueberry_jam.png",
	wield_image = "cucina_vegana_blueberry_jam.png",
	paramtype = "light",
	is_ground_content = false,
	on_use = minetest.item_eat(8),
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
	},
	groups = {dig_immediate = 3, attached_node = 1, food_vegan = 1, food_sweet = 1, eatable = 1},
})
minetest.register_craft({
	output = "cucina_vegana:blueberry_jam",
	recipe = {	{"cucina_vegana:blueberry_pot_cooked", "", ""},
                {"group:wool", "", ""},
				{"vessels:glass_bottle", "", ""}
			},
    replacements = {
            {"cucina_vegana:blueberry_pot_cooked", "bucket:bucket_empty"},
            {"group:wool", "farming:cotton"}
                   }
})
]]--
