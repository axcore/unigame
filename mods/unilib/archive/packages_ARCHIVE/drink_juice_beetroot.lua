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
minetest.register_node("better_farming:beetroot_juice", {
	description = "Beetroot Juice",
	on_use = minetest.item_eat(1),
	drawtype = "plantlike",
	tiles = {"beetroot_juice.png"},
	inventory_image = "beetroot_juice.png",
	wield_image = "beetroot_juice.png",
	paramtype = "light",
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
	},
	groups = {vessel = 1, dig_immediate = 3, attached_node = 1},
	sounds = default.node_sound_glass_defaults(),
})
minetest.register_craft({
	output = "better_farming:beetroot_juice",
	recipe = {
		{"vessels:glass_bottle", "better_farming:beetroot"},
	}
})
]]--
