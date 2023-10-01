---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_craftitem("farming:cutting_board", {
	description = S("Cutting Board"),
	inventory_image = "farming_cutting_board.png",
	groups = {food_cutting_board = 1, flammable = 2}
})
minetest.register_craft({
	output = "farming:cutting_board",
	recipe = {
		{"default:steel_ingot", "", ""},
		{"", "group:stick", ""},
		{"", "", "group:wood"}
	}
})
]]--
