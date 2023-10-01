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
minetest.register_tool("sickles:sickle_steel", {
	description = S("Steel Sickle"),
	inventory_image = "sickles_sickle_steel.png",
	tool_capabilities = {
		full_punch_interval = 0.8,
		max_drop_level = 1,
		groupcaps = {
			snappy = { times = { [1] = 2.5, [2] = 1.20, [3] = 0.35 }, uses = 60, maxlevel = 2 }
		},
		damage_groups = { fleshy = 3 },
		punch_attack_uses = 120
	},
	range = 6,
	groups = { sickle = 1, sickle_uses = 120 },
	sound = { breaks = "default_tool_breaks" }
})
minetest.register_craft({
	output = "sickles:sickle_steel",
	recipe = {
		{ "default:steel_ingot", "" },
		{ "", "default:steel_ingot" },
		{ "group:stick", "" }
	}
})
]]--
