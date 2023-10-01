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
minetest.register_craftitem("cheese:stretched_cheese", {
	description = S("Stretched Cheese"),
	inventory_image = "stretched_cheese.png",
	groups = {milk_product = 1},
})
minetest.register_craft({
	type = "shapeless",
	output = "cheese:stretched_cheese 4",
	recipe = {"cheese:curd", "cheese:curd", "cheese:curd", "bucket:bucket_water", "group:food_salt"},
	replacements = {{"bucket:bucket_water", "bucket:bucket_empty"}},
})
if minetest.get_modpath("wooden_bucket") then
	minetest.register_craft({
		type = "shapeless",
		output = "cheese:stretched_cheese 4",
		recipe = {"cheese:curd", "cheese:curd", "cheese:curd", "bucket_wooden:bucket_water", "group:food_salt"},
		replacements = {{"bucket_wooden:bucket_water", "bucket_wooden:bucket_empty"}},
	})
end
]]--
