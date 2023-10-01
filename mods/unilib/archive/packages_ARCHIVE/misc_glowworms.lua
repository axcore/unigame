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
minetest.register_node("caverealms:glow_worm", {
	description = "Glow Worms",
	tiles = {"caverealms_glow_worm.png"},
	inventory_image = "caverealms_glow_worm.png",
	wield_image = "caverealms_glow_worm.png",
	is_ground_content = true,
	groups = {oddly_breakable_by_hand=3},
	light_source = 9,
	paramtype = "light",
	drawtype = "plantlike",
	walkable = false,
	buildable_to = true,
	visual_scale = 1.0,
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.5, 0.5},
	},
})

minetest.register_node("caverealms:glow_worm_green", {
	description = "Green Glow Worms",
	tiles = {"caverealms_glow_worm_green.png"},
	inventory_image = "caverealms_glow_worm_green.png",
	wield_image = "caverealms_glow_worm_green.png",
	is_ground_content = true,
	groups = {oddly_breakable_by_hand=3},
	light_source = 9,
	paramtype = "light",
	drawtype = "plantlike",
	walkable = false,
	buildable_to = true,
	visual_scale = 1.0,
	selection_box = {
		type = "fixed",
		fixed = {-1/6, -1/2, -1/6, 1/6, 1/2, 1/6},
	},
})

]]--
