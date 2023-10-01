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
minetest.register_craftitem("cheese:whey", {
	description = S("Whey"),
	inventory_image = "whey.png",
	groups = {milk_product = 1},
})

if cheese.farming then
	minetest.register_craft({
		output = "farming:porridge",
		type = "shapeless",
		recipe = {"farming:oat", "farming:oat", "farming:oat" ,"farming:oat", "group:food_bowl",
        "cheese:whey"},
	})
end
]]--
