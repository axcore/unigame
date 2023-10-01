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
if cheese.ethereal then
	minetest.register_craftitem("cheese:seaweed_water_bucket", {
		description = S("Seaweed in a Water Bucket"),
		inventory_image = "seaweed_water_bucket.png",
		groups = { bucket = 1 },
	})

	minetest.register_craft({
		output = "cheese:seaweed_water_bucket",
		type = "shapeless",
		recipe = {"ethereal:seaweed", "ethereal:seaweed", "ethereal:seaweed", "bucket:bucket_water"	},
	})

	minetest.clear_craft({output = "ethereal:agar_powder"})
end
]]--
