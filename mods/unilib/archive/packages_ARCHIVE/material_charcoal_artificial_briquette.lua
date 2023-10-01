---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bbq
-- Code:    LGPL-2.1+
-- Media:   CC-BY-SA-3.0/CC-BY-3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_craftitem("bbq:charcoal_briquette", {
	description = ("Charcoal Briquette"),
	inventory_image = "bbq_charcoal_briquette.png",
	wield_image = "bbq_charcoal_briquette.png",
})
minetest.register_craft({
	output = "bbq:charcoal_briquette",
	recipe = {
		{"", "bbq:sawdust", ""},
		{"bbq:sawdust", "bbq:charcoal_lump", "bbq:sawdust"},
		{"", "bbq:sawdust", ""}
	}
})
minetest.register_craft({
	type = "fuel",
	recipe = "bbq:charcoal_briquette",
	burntime = 10,
})
]]--
