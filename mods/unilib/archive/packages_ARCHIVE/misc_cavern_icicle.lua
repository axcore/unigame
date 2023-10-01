---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    caverealms
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
--upward pointing icicle
minetest.register_node("caverealms:icicle_up", {
	description = "Icicle",
	tiles = {"caverealms_icicle_up.png"},
	inventory_image = "caverealms_icicle_up.png",
	wield_image = "caverealms_icicle_up.png",
	is_ground_content = true,
	groups = {cracky=3, oddly_breakable_by_hand=1},
	sounds = default.node_sound_glass_defaults(),
	light_source = 8,
	paramtype = "light",
	drawtype = "plantlike",
	walkable = false,
	buildable_to = true,
	visual_scale = 1.0,
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},
	},
})

--downward pointing icicle
minetest.register_node("caverealms:icicle_down", {
	description = "Icicle",
	tiles = {"caverealms_icicle_down.png"},
	inventory_image = "caverealms_icicle_down.png",
	wield_image = "caverealms_icicle_down.png",
	is_ground_content = true,
	groups = {cracky=3, oddly_breakable_by_hand=1},
	sounds = default.node_sound_glass_defaults(),
	light_source = 8,
	paramtype = "light",
	drawtype = "plantlike",
	walkable = false,
	buildable_to = true,
	visual_scale = 1.0,
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},
	},
})
]]--
