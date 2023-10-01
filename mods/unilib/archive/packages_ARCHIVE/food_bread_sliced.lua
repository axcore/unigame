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
minetest.register_craftitem("farming:bread_slice", {
	description = S("Sliced Bread"),
	inventory_image = "farming_bread_slice.png",
	on_use = minetest.item_eat(1),
	groups = {food_bread_slice = 1, flammable = 2}
})
minetest.register_craft({
	output = "farming:bread_slice 5",
	recipe = {{"group:food_cutting_board", "farming:bread"}},
	replacements = {{"group:food_cutting_board", "farming:cutting_board"}}
})
]]--
