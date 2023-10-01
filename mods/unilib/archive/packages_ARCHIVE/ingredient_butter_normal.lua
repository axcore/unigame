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
	minetest.register_craftitem("cheese:butter", {
		description = S("Butter"),
		inventory_image = "butter.png",
		groups = {milk_product = 1, food_butter = 1},
	})
	if minetest.registered_items["mobs:wooden_bucket_milk"] then
		table.insert(churnable, {"mobs:wooden_bucket_milk", "cheese:butter"})
	end
	table.insert(churnable, {"group:food_milk", 	"cheese:butter"		} )
	table.insert(churnable, {"cheese:milk_cream", "cheese:butter 2" } )
end
]]--
