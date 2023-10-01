---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    orienteering
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
-- Displays speed
minetest.register_tool("orienteering:speedometer", {
	description = S("Speedometer"),
	_tt_help = S("Shows your speed"),
	_doc_items_longdesc = S("It shows you your current horizontal (“hor.”) and vertical (“ver.”) speed in meters per second, where one meter is the side length of a single cube."),
	_doc_items_usagehelp = use,
	wield_image = "orienteering_speedometer_wield.png",
	inventory_image = "orienteering_speedometer_inv.png",
	groups = { disable_repair = 1 },
})
	minetest.register_craft({
		output = "orienteering:speedometer",
		recipe = {
			{"", "default:gold_ingot", ""},
			{"default:steel_ingot", "group:stick", "default:steel_ingot"},
			{"", "default:steel_ingot", ""},
		}
	})
]]--
