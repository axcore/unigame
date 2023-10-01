---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moreores
-- Code:    zlib
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
if minetest.get_modpath("carts") then
	carts:register_rail("moreores:copper_rail", {
		description = S("Copper Rail"),
		tiles = {
			"moreores_copper_rail.png",
			"moreores_copper_rail_curved.png",
			"moreores_copper_rail_t_junction.png",
			"moreores_copper_rail_crossing.png",
		},
		inventory_image = "moreores_copper_rail.png",
		wield_image = "moreores_copper_rail.png",
		groups = carts:get_rail_groups(),
	}, {})
end
minetest.register_craft({
	output = "moreores:copper_rail 24",
	recipe = {
		{"default:copper_ingot", "", "default:copper_ingot"},
		{"default:copper_ingot", "group:stick", "default:copper_ingot"},
		{"default:copper_ingot", "", "default:copper_ingot"},
	},
})
]]--
