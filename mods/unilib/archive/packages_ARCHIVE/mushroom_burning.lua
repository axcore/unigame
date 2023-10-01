---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    underch
-- Code:    CC0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("underch:burning_mushroom", {
	description = "Burning Mushroom",
	tiles = {{
		name = "underch_burning_mushroom.png",
		animation = {
			type = "vertical_frames",
			aspect_w = 16,
			aspect_h = 16,
			length = 0.5,
		},
	}},
	inventory_image = "[combine:16x16:0,0=underch_burning_mushroom.png",
	wield_image = "[combine:16x16:0,0=underch_burning_mushroom.png",
	drawtype = "plantlike",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	groups = {snappy = 3, attached_node = 1},
	sounds = default.node_sound_leaves_defaults(),
	on_use = minetest.item_eat(-2),
	light_source = 8,
	damage_per_second = 1,
	selection_box = {
		type = "fixed",
		fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 1 / 16, 4 / 16},
	}
})
]]--
