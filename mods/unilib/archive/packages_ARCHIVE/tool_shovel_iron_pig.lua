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
minetest.register_tool("pigiron:shovel_iron", {
	description = "Iron Shovel",
	inventory_image = "pigiron_iron_shovel.png",
	wield_image = "pigiron_iron_shovel.png^[transformR90",
	tool_capabilities = {
		full_punch_interval = 1.3,
		max_drop_level = 1,
		groupcaps = {
			crumbly = {
				times = {[1] = 1.70, [2] = 1.0, [3] = 0.45},
				uses = 25, maxlevel = 1
			},
		},
		damage_groups = {fleshy = 2},
	},
	groups = {shovel = 1},
	sound = {breaks = "default_tool_breaks"}
})
minetest.register_craft({
	output = "pigiron:shovel_iron",
	recipe = {
		{"pigiron:iron_ingot"},
		{"group:stick"},
		{"group:stick"}
	}
})
]]--
