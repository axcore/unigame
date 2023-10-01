---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    sickles
-- Code:    LGPL v3
-- Media:   CC BY-SA 3.0/4.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_tool("sickles:scythe_steel", {
	description = S("Steel Scythe"),
	inventory_image = "sickles_scythe_steel.png",
	tool_capabilities = {
		full_punch_interval = 1.2,
		damage_groups = { fleshy = 5 },
		punch_attack_uses = 180
	},
	range = 12,
	on_use = sickles.use_scythe,
	groups = { scythe = 2, scythe_uses = 30 },
	sound = { breaks = "default_tool_breaks" }
})
minetest.register_craft({
	output = "sickles:scythe_steel",
	recipe = {
		{ "", "default:steel_ingot", "default:steel_ingot" },
		{ "default:steel_ingot", "", "group:stick" },
		{ "", "", "group:stick" }
	}
})
]]--
