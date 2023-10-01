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
minetest.register_tool("xtraores:sword_excalibur", {
	description = "Excalibur | 75 dmg",
	inventory_image = "xtraores_sword_excalibur.png",
	tool_capabilities = {
		full_punch_interval = 0.1,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=0.0125, [2]=0.05, [3]=0.006}, uses=500, maxlevel=3},
		},
		damage_groups = {fleshy=75},
	}
})
minetest.register_craft({
	output = "xtraores:sword_excalibur",
	recipe = {
		{"xtraores:sword_osmium", "xtraores:sword_adamantite", "xtraores:sword_rarium"},
		{"xtraores:sword_cobalt", "default:sword_diamond", "xtraores:sword_unobtainium"},
		{"default:diamondblock", "default:mese", "default:diamondblock"},
	}
})
]]--
