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
minetest.register_tool("pigiron:pick_iron", {
	description = "Iron Pickaxe",
	inventory_image = "pigiron_iron_pick.png",
	tool_capabilities = {
		full_punch_interval = 1.2,
		max_drop_level = 1,
		groupcaps = {
			cracky = {
				times = {[1] = 2.5, [2] = 1.40, [3] = 0.95},
				uses = 20, maxlevel = 2
			},
		},
		damage_groups = {fleshy = 3},
	},
	groups = {pickaxe = 1},
	sound = {breaks = "default_tool_breaks"}
})
minetest.register_craft({
	output = "pigiron:pick_iron",
	recipe = {
		{"pigiron:iron_ingot", "pigiron:iron_ingot", "pigiron:iron_ingot"},
		{"", "group:stick", ""},
		{"", "group:stick", ""}
	}
})
]]--
