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
minetest.register_craftitem("ethereal:worm", {
	description = S("Worm"),
	inventory_image = "ethereal_worm.png",
	wield_image = "ethereal_worm.png"
})
minetest.register_craft({
	output = "ethereal:worm",
	recipe = {
		{"default:dirt","default:dirt"}
	}
})
]]--
