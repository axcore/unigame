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
minetest.register_craftitem("ethereal:palm_wax", {
	description = S("Palm Wax"),
	inventory_image = "ethereal_palm_wax.png",
	wield_image = "ethereal_palm_wax.png"
})
minetest.register_craft({
	type = "cooking",
	cooktime = 10,
	output = "ethereal:palm_wax",
	recipe = "ethereal:palmleaves"
})
]]--
