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
minetest.register_craftitem("ethereal:banana_dough", {
	description = S("Banana Dough"),
	inventory_image = "ethereal_banana_dough.png"
})
minetest.register_craft({
	output = "ethereal:banana_dough",
	recipe = {{"group:food_flour", "group:food_banana"}}
})
]]--
