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
if cheese.there_is_milk then
	minetest.register_craftitem("cheese:milk_cream", {
		description = S("Milk Cream"),
		inventory_image = "milk_cream.png",
		groups = {milk_product = 1, food_cream = 1},
	})
	if minetest.registered_items["mobs:wooden_bucket_milk"] then
		table.insert(creamable, {"mobs:wooden_bucket_milk", "cheese:milk_cream 3"})
	end
	table.insert(creamable, {"group:food_milk",	"cheese:milk_cream 3"})
	table.insert(creamable, {"cheese:whey",			"cheese:milk_cream"  })
end
]]--
