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
minetest.register_node("cucina_vegana:ciabatta_bread", {
	description = S("Ciabatta Bread"),
	drawtype = "plantlike",
	tiles = {"cucina_vegana_ciabatta_bread.png"},
	inventory_image = "cucina_vegana_ciabatta_bread.png",
	wield_image = "cucina_vegana_ciabatta_bread.png",
	paramtype = "light",
	is_ground_content = false,
	on_use = minetest.item_eat(4),
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
	},
	groups = {dig_immediate = 3, attached_node = 1, food_bread = 1, food_vegan = 1, eatable = 1},
})
minetest.register_craft({
	type = "cooking",
	cooktime = 17,
	output = "cucina_vegana:ciabatta_bread",
	recipe = "cucina_vegana:ciabatta_dough"
})
]]--
