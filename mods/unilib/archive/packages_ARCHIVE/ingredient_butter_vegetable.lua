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
minetest.register_craftitem("cheese:vegetable_butter", {
	description = S("Vegetable Butter"),
	inventory_image = "vegetable_butter.png",
	groups = {food_butter = 1, vegan_alternative = 1, food_vegan = 1},
})

minetest.register_craftitem("cheese:vegetable_butter_prep", {
	description = S("Vegetable Butter Preparation"),
	inventory_image = "vegetable_butter_prep.png",
	groups = {vegan_alternative = 1},
})

local vegetable_milks = {}
-- all use vessels:drinking_glass
if cheese.farming then table.insert(vegetable_milks, "farming:soy_milk") end
if cheese.cv then table.insert(vegetable_milks, "cucina_vegana:soy_milk") end
if cheese.ethereal or cheese.moretrees then table.insert(vegetable_milks, "group:food_coconut_milk") end

for i=1,#vegetable_milks do
	minetest.register_craft({
		output = "cheese:vegetable_butter_prep",
		type = "shapeless",
		recipe = { "group:food_oil" , "cheese:coconut_cream", "cheese:coconut_cream", vegetable_milks[i], vegetable_milks[i] },
		replacements = {{vegetable_milks[i] , "vessels:drinking_glass"},
		{vegetable_milks[i] , "vessels:drinking_glass"},
		{"group:food_oil" , "vessels:glass_bottle"}, },
	})
end
]]--
