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
minetest.register_craftitem("farming:popcorn", {
	description = S("Popcorn"),
	inventory_image = "farming_popcorn.png",
	groups = {food_popcorn = 1, flammable = 2},
	on_use = minetest.item_eat(4)
})
minetest.register_craft({
	output = "farming:popcorn",
	recipe = {
		{"group:food_pot", "group:food_oil", "group:food_corn"}
	},
	replacements = {
		{"group:food_pot", "farming:pot"},
		{"group:food_oil", "vessels:glass_bottle"}
	}
})
]]--
