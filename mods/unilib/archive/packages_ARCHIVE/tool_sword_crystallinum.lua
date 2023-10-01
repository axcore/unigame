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
minetest.register_tool("ethereal:sword_crystal", {
	description = S("Crystal Sword"),
	inventory_image = "ethereal_crystal_sword.png",
	wield_image = "ethereal_crystal_sword.png",
	tool_capabilities = {
		full_punch_interval = 0.6,
		max_drop_level = 1,
		groupcaps = {
			snappy = {
				times = {[1] = 1.70, [2] = 0.70, [3] = 0.25},
				uses = 50,
				maxlevel = 3
			},
		},
		damage_groups = {fleshy = 10},
	},
	groups = {sword = 1},
	sound = {breaks = "default_tool_breaks"}
})
minetest.register_craft({
	output = "ethereal:sword_crystal",
	recipe = {
		{"ethereal:crystal_ingot"},
		{"ethereal:crystal_ingot"},
		{"default:steel_ingot"}
	}
})
]]--
