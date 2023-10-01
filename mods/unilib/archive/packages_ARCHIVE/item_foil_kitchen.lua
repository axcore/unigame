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
minetest.register_craftitem("bbq:foil", {
	description = ("Foil"),
	inventory_image = "bbq_foil.png",
	wield_image = "bbq_foil.png",
})
minetest.register_craft({
	output = "bbq:foil",
	recipe = {
		{"", "", ""},
		{"", "", ""},
		{"default:tin_ingot", "default:tin_ingot", "default:tin_ingot"}
	}
})
]]--
