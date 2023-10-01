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
minetest.register_craftitem("cucina_vegana:dandelion_suds", {
	description = S("Dandelion Suds"),
	inventory_image = "cucina_vegana_dandelion_suds.png",
	groups = {sud = 1,},
})
minetest.register_craft({
	output = "cucina_vegana:dandelion_suds",
	recipe = {	{"flowers:dandelion_yellow", "flowers:dandelion_yellow", "flowers:dandelion_yellow"},
				{"flowers:dandelion_yellow", "flowers:dandelion_yellow", "flowers:dandelion_yellow"},
                {"", "bucket:bucket_water", ""}
			}
})
minetest.register_craft({
	output = "cucina_vegana:dandelion_suds",
	recipe = {	{"flowers:dandelion_yellow", "flowers:dandelion_yellow", "flowers:dandelion_yellow"},
				{"flowers:dandelion_yellow", "flowers:dandelion_yellow", "flowers:dandelion_yellow"},
                {"", "bucket:bucket_river_water", ""}
			}
})

minetest.register_craftitem("cucina_vegana:dandelion_suds_cooking", {
	description = S("Dandelion Suds (cooking)"),
	inventory_image = "cucina_vegana_dandelion_suds_cooking.png",
	groups = {sud = 1,},
})
minetest.register_craft({
	type = "cooking",
	cooktime = 20,
	output = "cucina_vegana:dandelion_suds_cooking",
	recipe = "cucina_vegana:dandelion_suds"
})
]]--
