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
minetest.register_craftitem("cucina_vegana:rice_starch", {
    description = S("Rice Starch"),
    groups = {food_vegan = 1, food_starch = 1},
    inventory_image = "cucina_vegana_rice_starch.png",
})
minetest.register_craft({
	output = "cucina_vegana:rice_starch 2",
	recipe = {	{"wool:white", "cucina_vegana:rice", "wool:white"},
				{"wool:white", "cucina_vegana:rice", "wool:white"},
                {"", "bucket:bucket_water", ""}
			},
    replacements = {
                {"wool:white", "farming:cotton 2"},
                {"bucket:bucket_water", "bucket:bucket_empty"}
            }

})
minetest.register_craft({
	output = "cucina_vegana:rice_starch 2",
	recipe = {	{"wool:white", "cucina_vegana:rice", "wool:white"},
				{"wool:white", "cucina_vegana:rice", "wool:white"},
                {"", "bucket:bucket_river_water", ""}
			},
    replacements = {
                {"wool:white", "farming:cotton 2"},
                {"bucket:bucket_river_water", "bucket:bucket_empty"}
            }

})
]]--
