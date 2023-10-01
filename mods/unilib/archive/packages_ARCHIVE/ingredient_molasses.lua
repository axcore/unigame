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
minetest.register_craftitem("cucina_vegana:molasses", {
	description = S("Molasses"),
	inventory_image = "cucina_vegana_molasses.png",
	groups = {flammable = 1, food = 1, food_sugar = 1},
})
minetest.register_craft({
	output = "cucina_vegana:molasses",
	recipe = {
				{"", "default:stick", ""},
				{"cucina_vegana:kohlrabi", "vessels:drinking_glass", "cucina_vegana:kohlrabi"},
                {"", "bucket:bucket_water", ""},
			},
			replacements = {
							{"bucket:bucket_water", "bucket:bucket_empty"},
                            {"default:stick", "default:stick"}
						}
})
minetest.register_craft({
	output = "cucina_vegana:molasses",
	recipe = {
				{"", "default:stick", ""},
				{"cucina_vegana:kohlrabi", "vessels:drinking_glass", "cucina_vegana:kohlrabi"},
                {"", "bucket:bucket_river_water", ""},
			},
			replacements = {
							{"bucket:bucket_river_water", "bucket:bucket_empty"},
                            {"default:stick", "default:stick"}
						}
})
minetest.register_craft({
	type = "cooking",
	cooktime = 14,
	output = "bushes:sugar",
	recipe = "cucina_vegana:molasses",
    replacements = {{"cucina_vegana:molasses", "vessels:drinking_glass"}}
})
minetest.register_craft({
	type = "fuel",
	recipe = "cucina_vegana:molasses",
	burntime = 10,
})
if(minetest.get_modpath("technic")) then

	-- Support Compressor
	local compressor_recipes = {
                    {"cucina_vegana:kohlrabi 6", "cucina_vegana:molasses"},
                }
	for _, data in pairs(compressor_recipes) do

		technic.register_compressor_recipe({input = {data[1]}, output = data[2]})

	end

	-- Support Centrifuge
	local centrifuge_recipes = {
                    { "cucina_vegana:kohlrabi 4",      "cucina_vegana:molasses",                "default:leaves"  },
				}

	for _, data in pairs(centrifuge_recipes) do

		technic.register_separating_recipe({ input = { data[1] }, output = { data[2], data[3], data[4] } })

	end

	-- Support Extractor
	local extractor_recipes = {
        {"cucina_vegana:kohlrabi 3", "cucina_vegana:molasses"},
        {"cucina_vegana:molasses", "bushes:sugar 2"},
	}

	for _, data in ipairs(extractor_recipes) do
		technic.register_extractor_recipe({input = {data[1]}, output = data[2]})
	end
    
end
]]--
