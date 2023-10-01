---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    pigiron
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_tool("pigiron:axe_iron", {
	description = "Iron Axe",
	inventory_image = "pigiron_iron_axe.png",
	tool_capabilities = {
		full_punch_interval = 1.1,
		max_drop_level = 1,
		groupcaps = {
			choppy = {
				times = {[1] = 2.70, [2] = 1.70, [3] = 1.15},
				uses = 20, maxlevel = 1
			},
		},
		damage_groups = {fleshy = 3},
	},
	groups = {axe = 1},
	sound = {breaks = "default_tool_breaks"}
})
minetest.register_craft({
	output = "pigiron:axe_iron",
	recipe = {
		{"pigiron:iron_ingot", "pigiron:iron_ingot"},
		{"pigiron:iron_ingot", "group:stick"},
		{"", "group:stick"}
	}
})
]]--
