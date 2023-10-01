---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    minimap_radar
-- Code:    MIT
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_craftitem("minimap_radar:radar", {
	description = "Radar\nUse with 'Minimap' key",
	inventory_image = "minimap_radar_radar.png",
	stack_max = 1,
	on_use = function(itemstack, user, pointed_thing)
		map.update_hud_flags(user)
	end
})
if minetest.get_modpath("technic") then
	minetest.register_craft({
		output = "minimap_radar:radar",
		recipe = {
			{"technic:stainless_steel_ingot", "default:diamond", "technic:stainless_steel_ingot"},
			{"dye:green", "technic:prospector", "dye:black"},
			{"technic:stainless_steel_ingot", "default:diamond", "technic:stainless_steel_ingot"},
		}
	})
elseif minetest.get_modpath("moreores") then
	minetest.register_craft({
		output = "minimap_radar:radar",
		recipe = {
			{"moreores:silver_ingot", "default:diamond", "moreores:silver_ingot"},
			{"dye:green", "moreores:mithril_block", "dye:black"},
			{"moreores:silver_ingot", "default:diamond", "moreores:silver_ingot"},
		}
	})
else
	minetest.register_craft({
		output = "minimap_radar:radar",
		recipe = {
			{"default:steel_ingot", "default:diamond", "default:steel_ingot"},
			{"dye:green", "default:mese", "dye:black"},
			{"default:steel_ingot", "default:diamond", "default:steel_ingot"},
		}
	})
end
]]--
