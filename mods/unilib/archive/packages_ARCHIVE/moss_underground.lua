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
minetest.register_node("underch:moss", {
	description = "Moss",
	drawtype = "signlike",
	tiles = {"underch_moss.png"},
	inventory_image = "underch_moss.png",
	wield_image = "underch_moss.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	walkable = false,
	is_ground_content = false,
	buildable_to = true,
	selection_box = {
		type = "wallmounted",
	},
	groups = {oddly_breakable_by_hand = 3},
	sounds = default.node_sound_leaves_defaults(),
})
minetest.register_craft({
	type = "fuel",
	recipe = "underch:moss",
	burntime = 2,
})
]]--
