---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xtraores
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_tool("xtraores:spear_gungir", {
	description = "The Gungir (spear) | 160 dmg",
	inventory_image = "xtraores_spear_gungir.png",
	range = 12,
	tool_capabilities = {
		full_punch_interval = 0.3,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=2.0, [2]=1.00, [3]=0.35}, uses=200, maxlevel=3},
		},
		damage_groups = {fleshy=160},
	}
})
minetest.register_craft({
	output = "xtraores:spear_gungir",
	recipe = {
		{"xtraores:sword_excalibur", "xtraores:geminitinum_ingot", "xtraores:sword_excalibur"},
		{"xtraores:geminitinum_ingot", "xtraores:spear_geminitinum", "xtraores:geminitinum_ingot"},
		{"xtraores:sword_excalibur", "xtraores:geminitinum_ingot", "xtraores:sword_excalibur"},
	}
})
]]--
