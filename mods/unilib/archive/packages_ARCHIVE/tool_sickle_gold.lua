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
minetest.register_tool("sickles:sickle_gold", {
	description = S("Golden Sickle"),
	inventory_image = "sickles_sickle_gold.png",
	tool_capabilities = {
		full_punch_interval = 0.8,
		max_drop_level = 1,
		groupcaps = {
			snappy = { times = { [1] = 2.0, [2] = 1.00, [3] = 0.35 }, uses = 45, maxlevel = 3 }
		},
		damage_groups = { fleshy = 2 },
		punch_attack_uses = 90
	},
	range = 6,
	groups = { sickle = 1, sickle_uses = 90 },
	sound = { breaks = "default_tool_breaks" }
})
minetest.register_craft({
	output = "sickles:sickle_gold",
	recipe = {
		{ "default:gold_ingot", "" },
		{ "", "default:gold_ingot" },
		{ "group:stick", "" }
	}
})
]]--
