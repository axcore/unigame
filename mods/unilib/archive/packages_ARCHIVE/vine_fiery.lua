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
minetest.register_node("underch:fiery_vine", {
	description = "Fiery Vine",
	drawtype = "signlike",
	tiles = {"underch_fiery_vine.png"},
	inventory_image = "underch_fiery_vine.png",
	wield_image = "underch_fiery_vine.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	walkable = false,
	climbable = true,
	is_ground_content = false,
	selection_box = {
		type = "wallmounted",
	},
	groups = {choppy = 3, oddly_breakable_by_hand = 1, hot = 1},
	legacy_wallmounted = true,
	light_source = 8,
	sounds = default.node_sound_leaves_defaults(),
	damage_per_second = 1 * underch.damage_scaling_factor,
})
minetest.register_craft({
	type = "fuel",
	recipe = "underch:fiery_wine",
	burntime = 8,
})
]]--
