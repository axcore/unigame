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
minetest.register_craftitem("farming:chocolate_dark", {
	description = S("Bar of Dark Chocolate"),
	inventory_image = "farming_chocolate_dark.png",
	on_use = minetest.item_eat(3)
})
minetest.register_craft( {
	output = "farming:chocolate_dark",
	recipe = {
		{"group:food_cocoa", "group:food_cocoa", "group:food_cocoa"}
	}
})

minetest.register_node("farming:chocolate_block", {
	description = S("Chocolate Block"),
	tiles = {"farming_chocolate_block.png"},
	is_ground_content = false,
	groups = {cracky = 2, oddly_breakable_by_hand = 2},
	sounds = default.node_sound_stone_defaults()
})
minetest.register_craft({
	output = "farming:chocolate_block",
	recipe = {
		{"farming:chocolate_dark", "farming:chocolate_dark", "farming:chocolate_dark"},
		{"farming:chocolate_dark", "farming:chocolate_dark", "farming:chocolate_dark"},
		{"farming:chocolate_dark", "farming:chocolate_dark", "farming:chocolate_dark"}
	}
})
minetest.register_craft({
	output = "farming:chocolate_dark 9",
	recipe = {{"farming:chocolate_block"}}
})
]]--
