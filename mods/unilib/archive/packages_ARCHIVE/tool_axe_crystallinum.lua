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
minetest.register_tool("ethereal:axe_crystal", {
	description = S("Crystal Axe"),
	inventory_image = "ethereal_crystal_axe.png",
	wield_image = "ethereal_crystal_axe.png",
	tool_capabilities = {
		full_punch_interval = 0.8,
		max_drop_level = 1,
		groupcaps = {
			choppy = {
				times = {[1] = 2.00, [2] = 0.80, [3] = 0.40},
				uses = 40,
				maxlevel = 3
			}
		},
		damage_groups = {fleshy = 7}
	},
	groups = {axe = 1},
	sound = {breaks = "default_tool_breaks"}
})
minetest.register_craft({
	output = "ethereal:axe_crystal",
	recipe = {
		{"ethereal:crystal_ingot", "ethereal:crystal_ingot"},
		{"ethereal:crystal_ingot", "default:steel_ingot"},
		{"", "default:steel_ingot"}
	}
})
minetest.register_craft({
	output = "ethereal:axe_crystal",
	recipe = {
		{"ethereal:crystal_ingot", "ethereal:crystal_ingot"},
		{"default:steel_ingot", "ethereal:crystal_ingot"},
		{"default:steel_ingot", ""}
	}
})
]]--
