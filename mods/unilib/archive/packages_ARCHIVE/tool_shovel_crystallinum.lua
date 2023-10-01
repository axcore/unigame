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
minetest.register_tool("ethereal:shovel_crystal", {
	description = "Crystal Shovel",
	inventory_image = "ethereal_crystal_shovel.png",
	wield_image = "ethereal_crystal_shovel.png^[transformR90",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level = 1,
		groupcaps = {
			crumbly = {
				times = {[1] = 1.10, [2] = 0.50, [3] = 0.30},
				uses = 30,
				maxlevel = 3
			}
		},
		damage_groups = {fleshy = 4}
	},
	groups = {shovel = 1},
	sound = {breaks = "default_tool_breaks"}
})
minetest.register_craft({
	output = "ethereal:shovel_crystal",
	recipe = {
		{"ethereal:crystal_ingot"},
		{"default:steel_ingot"},
		{"default:steel_ingot"}
	}
})
]]--
