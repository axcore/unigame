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
minetest.register_craftitem("cucina_vegana:blueberry_pot", {
	description = S("Blueberry pot"),
	inventory_image = "cucina_vegana_blueberry_pot.png",
	groups = {sud = 1},
})
minetest.register_craft({
	output = "cucina_vegana:blueberry_pot",
	recipe = {	{"group:food_sugar", "default:stick", "group:food_sugar"},
				{"cucina_vegana:blueberry_puree", "cucina_vegana:blueberry_puree", "cucina_vegana:blueberry_puree"},
                {"", "bucket:bucket_water", ""}
			},
    replacements = {
                    {"default:stick", "default:stick"}
                   }
})
minetest.register_craft({
	output = "cucina_vegana:blueberry_pot",
	recipe = {	{"group:food_sugar", "default:stick", "group:food_sugar"},
				{"cucina_vegana:blueberry_puree", "cucina_vegana:blueberry_puree", "cucina_vegana:blueberry_puree"},
                {"", "bucket:bucket_river_water", ""}
			},
    replacements = {
                    {"default:stick", "default:stick"}
                   }
})
minetest.register_craft({
	output = "cucina_vegana:blueberry_pot",
	recipe = {	{"cucina_vegana:molasses", "default:stick", "cucina_vegana:molasses"},
				{"cucina_vegana:blueberry_puree", "cucina_vegana:blueberry_puree", "cucina_vegana:blueberry_puree"},
                {"", "bucket:bucket_water", ""}
			},
    replacements = {
                        {"default:stick", "default:stick"},
                        {"cucina_vegana:molasses", "vessels:drinking_glass 2"}
                   }
})
minetest.register_craft({
	output = "cucina_vegana:blueberry_pot",
	recipe = {	{"cucina_vegana:molasses", "default:stick", "cucina_vegana:molasses"},
				{"cucina_vegana:blueberry_puree", "cucina_vegana:blueberry_puree", "cucina_vegana:blueberry_puree"},
                {"", "bucket:bucket_river_water", ""}
			},
    replacements = {
                        {"default:stick", "default:stick"},
                        {"cucina_vegana:molasses", "vessels:drinking_glass 2"}
                   }
})

minetest.register_craftitem("cucina_vegana:blueberry_pot_cooked", {
	description = S("Blueberry pot (cooked)"),
	inventory_image = "cucina_vegana_blueberry_pot_cooked.png",
	groups = {sud = 1},
})
minetest.register_craft({
	type = "cooking",
	cooktime = 25,
	output = "cucina_vegana:blueberry_pot_cooked",
	recipe = "cucina_vegana:blueberry_pot"
})
]]--
