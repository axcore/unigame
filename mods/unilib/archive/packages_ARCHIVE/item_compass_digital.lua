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
-- Displays player yaw
minetest.register_tool("orienteering:compass", {
	description = S("Compass"),
	_tt_help = S("Shows your yaw"),
	_doc_items_longdesc = S("It shows you your yaw (horizontal viewing angle) in degrees."),
	_doc_items_usagehelp = use,
	wield_image = "orienteering_compass_wield.png",
	inventory_image = "orienteering_compass_inv.png",
	groups = { disable_repair = 1 },
})
	minetest.register_craft({
		output = "orienteering:compass",
		recipe = {
			{"", "default:tin_ingot", ""},
			{"default:tin_ingot", "group:stick", "default:tin_ingot"},
			{"", "default:tin_ingot", ""},
		}
	})

]]--
