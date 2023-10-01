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
minetest.register_tool("ethereal:crystal_gilly_staff", {
	description = S("Crystal Gilly Staff"),
	inventory_image = "ethereal_crystal_gilly_staff.png",
	wield_image = "ethereal_crystal_gilly_staff.png",

	on_use = function(itemstack, user, pointed_thing)
		if user:get_breath() < 10 then
			user:set_breath(10)
		end
	end
})
minetest.register_craft({
	type = "shapeless",
	output = "ethereal:crystal_gilly_staff",
	recipe = {
		"ethereal:green_moss", "ethereal:gray_moss", "ethereal:fiery_moss",
		"ethereal:crystal_moss", "ethereal:crystal_ingot", "ethereal:mushroom_moss",
		"ethereal:crystal_ingot"
	},
})
]]--
