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
minetest.register_tool("pigiron:sword_iron", {
	description = "Iron Sword",
	inventory_image = "pigiron_iron_sword.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level = 1,
		groupcaps = {
			snappy = {
				times = {[1] = 2.0, [2] = 1.30, [3] = 0.38},
				uses = 25, maxlevel = 1
			},
		},
		damage_groups = {fleshy = 5},
	},
	groups = {sword = 1},
	sound = {breaks = "default_tool_breaks"}
})
minetest.register_craft({
	output = "pigiron:sword_iron",
	recipe = {
		{"pigiron:iron_ingot"},
		{"pigiron:iron_ingot"},
		{"group:stick"}
	}
})
]]--
