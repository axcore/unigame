---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cheese
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED / CC0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
if minetest.get_modpath("bonemeal") or minetest.get_modpath("petz") then
	minetest.register_craftitem("cheese:bones_water_bucket", {
		description = S("Bones in a Water Bucket"),
		inventory_image = "bones_water_bucket.png",
		groups = { bucket = 1 },
	})

	minetest.register_craft({
		output = "cheese:bones_water_bucket",
		type = "shapeless",
		recipe = {"group:bone", "group:bone", "group:bone", "bucket:bucket_water"	},
	})
end
]]--
