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
-- Displays player pitch
minetest.register_tool("orienteering:sextant", {
	description = S("Sextant"),
	_tt_help = S("Shows your pitch"),
	_doc_items_longdesc = S("It shows you your pitch (vertical viewing angle) in degrees."),
	_doc_items_usagehelp = use,
	wield_image = "orienteering_sextant_wield.png",
	inventory_image = "orienteering_sextant_inv.png",
	groups = { disable_repair = 1 },
})
	minetest.register_craft({
		output = "orienteering:sextant",
		recipe = {
			{"", "default:gold_ingot", ""},
			{"default:gold_ingot", "default:gold_ingot", "default:gold_ingot"},
		}
	})
]]--
