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
minetest.register_node("cucina_vegana:peanut_butter", {
	description = S("Peanut Butter"),
	drawtype = "plantlike",
	tiles = {"cucina_vegana_peanut_butter.png"},
	inventory_image = "cucina_vegana_peanut_butter.png",
	wield_image = "cucina_vegana_peanut_butter.png",
	paramtype = "light",
	is_ground_content = false,
	on_use = minetest.item_eat(10),
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
	},
	groups = {dig_immediate = 3, attached_node = 1, food_vegan = 1, food_sweet = 1, food_butter = 1, eatable = 1},
})
minetest.register_craft({
	output = "cucina_vegana:peanut_butter",
	recipe = {
				{"cucina_vegana:peanut", "default:stick", "cucina_vegana:peanut"},
				{"cucina_vegana:peanut", "group:food_butter", "cucina_vegana:peanut"},
                {"", "vessels:glass_bottle", ""},
			},
			replacements = {
							{"default:stick", "default:stick"},
						}
})
]]--
