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
minetest.register_tool("sickles:scythe_bronze", {
	description = S("Bronze Scythe"),
	inventory_image = "sickles_scythe_bronze.png",
	tool_capabilities = {
		full_punch_interval = 1.2,
		damage_groups = { fleshy = 5 },
		punch_attack_uses = 160
	},
	range = 12,
	on_use = sickles.use_scythe,
	groups = { scythe = 2, scythe_uses = 25 },
	sound = { breaks = "default_tool_breaks" }
})
minetest.register_craft({
	output = "sickles:scythe_bronze",
	recipe = {
		{ "", "default:bronze_ingot", "default:bronze_ingot" },
		{ "default:bronze_ingot", "", "group:stick" },
		{ "", "", "group:stick" }
	}
})
]]--
