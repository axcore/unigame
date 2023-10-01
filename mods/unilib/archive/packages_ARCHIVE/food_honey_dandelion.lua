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
minetest.register_craftitem("cucina_vegana:dandelion_honey", {
	description = S("Dandelion Honey"),
	inventory_image = "cucina_vegana_dandelion_honey.png",
	groups = {flammable = 1, food = 1, food_honey = 1, food_sugar = 1, eatable = 1},
    on_use = minetest.item_eat(3),
})
minetest.register_craft({
	output = "cucina_vegana:dandelion_honey",
	recipe = {	{"cucina_vegana:dandelion_suds_cooking", "", ""},
                {"group:wool", "", ""},
				{"vessels:glass_bottle", "", ""}
			},
    replacements = {
            {"cucina_vegana:dandelion_suds_cooking", "bucket:bucket_empty"},
            {"group:wool", "farming:cotton 2"}
                   }
})
]]--
