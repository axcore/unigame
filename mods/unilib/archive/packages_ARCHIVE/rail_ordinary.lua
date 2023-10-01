---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    carts
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
carts:register_rail("carts:rail", {
	description = S("Rail"),
	tiles = {
		"carts_rail_straight.png", "carts_rail_curved.png",
		"carts_rail_t_junction.png", "carts_rail_crossing.png"
	},
	inventory_image = "carts_rail_straight.png",
	wield_image = "carts_rail_straight.png",
	groups = carts:get_rail_groups(),
}, {})
minetest.register_craft({
	output = "carts:rail 18",
	recipe = {
		{"default:steel_ingot", "group:wood", "default:steel_ingot"},
		{"default:steel_ingot", "", "default:steel_ingot"},
		{"default:steel_ingot", "group:wood", "default:steel_ingot"},
	}
})
]]--
