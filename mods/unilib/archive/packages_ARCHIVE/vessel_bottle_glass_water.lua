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
minetest.register_node("better_farming:glass_bottle_with_water", {
	description = "Glass Bottle With Water",
	drawtype = "plantlike",
	tiles = {"better_farming_glass_bottle_with_water.png"},
	inventory_image = "better_farming_glass_bottle_with_water.png",
	wield_image = "better_farming_glass_bottle_with_water.png",
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
	output = "better_farming:glass_bottle_with_water 4",
	recipe = {
		{"vessels:glass_bottle", "default:water_source"},
	}
})
]]--
