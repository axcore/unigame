---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_craftitem("ethereal:fugu", {
	description = S("Fugusashi"),
	inventory_image = "ethereal_fugu.png",
	on_use = function(itemstack, user, pointed_thing)
		if user then
			if math.random(12) == 1 then
				return minetest.do_item_eat(-16, nil, itemstack, user, pointed_thing)
			else
				return minetest.do_item_eat(4, nil, itemstack, user, pointed_thing)
			end
		end
	end
})
minetest.register_craft({
	output = "ethereal:fugu",
	recipe = {
		{"group:food_cutting_board", "ethereal:fish_pufferfish", "group:food_soy_sauce"}
	},
	replacements = {
		{"group:food_cutting_board", "farming:cutting_board"},
		{"group:food_soy_sauce", "vessels:glass_bottle"}
	}
})
]]--
