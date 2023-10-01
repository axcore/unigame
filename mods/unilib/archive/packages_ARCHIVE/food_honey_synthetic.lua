---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xdecor
-- Code:    BSD
-- Media:   WTFPL/CC BY-SA/CC BY 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_craftitem("xdecor:honey", {
	description = S("Honey"),
	inventory_image = "xdecor_honey.png",
	wield_image = "xdecor_honey.png",
	on_use = minetest.item_eat(2),
	groups = {
		food_honey = 1,
		food_sugar = 1,
		flammable = 2,
		not_in_creative_inventory = 1,
	},
})
]]--
