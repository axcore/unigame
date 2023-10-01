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
-- Displays height (Y)
minetest.register_tool("orienteering:altimeter", {
	description = S("Altimeter"),
	_tt_help = S("Shows your elevation"),
	_doc_items_longdesc = S("It shows you your current elevation (Y)."),
	_doc_items_usagehelp = use,
	wield_image = "orienteering_altimeter.png",
	inventory_image = "orienteering_altimeter.png",
	groups = { disable_repair = 1 },
})
	minetest.register_craft({
		output = "orienteering:altimeter",
		recipe = {
			{"default:glass"},
			{"default:steel_ingot"},
			{"default:steel_ingot"},
		}
	})
]]--
