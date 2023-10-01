---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    better_farming
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_craftitem("better_farming:candy_cane", {
	description = minetest.colorize("Pink","Candy Cane"),
	inventory_image = "candy_cane.png",
	on_use = minetest.item_eat(2),
	groups = {food_candy = 1, flammable = 2},
})
minetest.register_craft({
	output = "better_farming:candy_cane",
	recipe = {
		{"better_farming:sugar", "better_farming:glass_bottle_with_water", "better_farming:corn"},
	}
})

minetest.register_node("better_farming:candy_cane_block", {
	description = minetest.colorize("Pink","Candy Cane Block"),
	tiles = {"candy_cane_block_top.png", "candy_cane_block_bottom.png",
		"candy_cane_block.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults(),

	on_place = minetest.rotate_node
})
minetest.register_craft({
	output = "better_farming:candy_cane_block",
	recipe = {
		{"better_farming:candy_cane", "better_farming:candy_cane"},
		{"better_farming:candy_cane", "better_farming:candy_cane"},
	}
})
]]--
