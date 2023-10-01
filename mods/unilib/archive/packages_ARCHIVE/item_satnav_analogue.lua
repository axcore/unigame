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
if not mod_map then
	-- Enables minimap (surface)
	minetest.register_tool("orienteering:map", {
		description = S("Map"),
		_tt_help = S("Allows using the minimap"),
		_doc_items_longdesc = S("The map allows you to view a minimap of the area around you."),
		_doc_items_usagehelp = S("If you put a map in your hotbar, you will be able to access the minimap (only surface mode). Press the “minimap” key to view the minimap."),
		wield_image = "orienteering_map.png",
		wield_scale = { x=1.5, y=1.5, z=0.15 },
		inventory_image = "orienteering_map.png",
		groups = { disable_repair = 1 },
	})
end
	if (not mod_map) and minetest.get_modpath("dye") then
		minetest.register_craft({
			output = "orienteering:map",
			recipe = {
				{ "default:paper", "default:paper", "default:paper" },
				{ "default:paper", "dye:black", "default:paper" },
				{ "default:paper", "default:paper", "default:paper" },
			}
		})
	end
]]--
