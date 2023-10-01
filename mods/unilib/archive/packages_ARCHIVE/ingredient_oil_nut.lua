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
--ethereal has olive, cucina_vegana has lots and farming has the least favourite hemp oil, still there could be no item belonging to the group:food_oil
if not ( cheese.farming or cheese.ethereal or cheese.cv ) then
	if cheese.moretrees then
		minetest.register_craftitem("cheese:nut_oil", {
			description = S("Nut Oil"),
			inventory_image = "nut_oil.png",
			groups = {food_oil = 1, vegan_alternative = 1, vessel = 1},
		})
		local nuts = {"moretrees:spruce_nuts", "moretrees:fir_nuts", "moretrees:cedar_nuts"}
		for i=1,#nuts do
			minetest.override_item(nuts[i], {
				groups = {food = 1, food_nut = 1},
			})
		end
		minetest.register_craft({
			output = "cheese:nut_oil",
			type = "shapeless",
			recipe = { "vessels:glass_bottle", "group:food_nut", "group:food_nut", "group:food_nut", "group:food_nut", "group:food_nut" },
		})
	else -- default-only alternative, a bit non-sense, but it is something... i would have used starch but there isnt in this case
		minetest.register_craft({
			output = "cheese:vegetable_butter_prep",
			type = "shapeless",
			recipe = { "default:sand_with_kelp" , "cheese:cactus_cream", "cheese:cactus_cream", "group:water_bucket" },
			replacements = {{"group:water_bucket", "bucket:bucket_empty"}}
		})
	end -- if moretrees, one oil is registerable
end -- if there is no known food oil registered already
]]--
