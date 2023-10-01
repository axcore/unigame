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
-- Enables minimap (radar)
minetest.register_tool("orienteering:automapper", {
	description = S("Radar Mapper"),
	_tt_help = S("Allows using the minimap and radar"),
	_doc_items_longdesc = S("The radar mapper is a device that combines a map with a radar. It unlocks both the surface mode and radar mode of the minimap."),
	_doc_items_usagehelp = S("If you put a radar mapper in your hotbar, you will be able to access the minimap. Press the “minimap” key to view the minimap."),
	wield_image = "orienteering_automapper_wield.png",
	wield_scale = { x=1, y=1, z=2 },
	inventory_image = "orienteering_automapper_inv.png",
	groups = { disable_repair = 1 },
})
	minetest.register_craft({
		output = "orienteering:automapper",
		recipe = {
			{"default:gold_ingot", "default:gold_ingot", "default:gold_ingot"},
			{"default:mese_crystal", "default:obsidian_shard", "default:mese_crystal"},
			{"default:gold_ingot", "default:gold_ingot", "default:gold_ingot"}
		}
	})
]]--
