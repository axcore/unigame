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
minetest.register_craftitem("ethereal:bucket_cactus", {
	description = S("Bucket of Cactus Pulp"),
	inventory_image = "bucket_cactus.png",
	wield_image = "bucket_cactus.png",
	stack_max = 1,
	groups = {vessel = 1, drink = 1},
	on_use = minetest.item_eat(2, "bucket:bucket_empty"),
})
minetest.register_craft({
	output = "ethereal:bucket_cactus",
	recipe = {{"bucket:bucket_empty","default:cactus"}}
})
]]--
