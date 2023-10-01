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
	minetest.register_craftitem("cheese:ice_cream_base", {
		description = S("Ice Cream"),
		inventory_image = "ice_cream_base.png",
		on_use = minetest.item_eat(3),
		groups = {milk_product = 1, food = 5, food_icecream = 1, food_icecream_base = 1},
	})
	minetest.register_craft({
		type = "shapeless",
		output = "cheese:ice_cream_base 4",
		recipe = {"group:food_milk", "cheese:milk_cream", "cheese:milk_cream", "group:food_sugar", "default:snow"},
		replacements = {{"group:food_milk", "bucket:bucket_empty"}},
	})
end
]]--
