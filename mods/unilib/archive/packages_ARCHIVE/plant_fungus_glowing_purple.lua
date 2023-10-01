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
minetest.register_node("caverealms:fungus", {
	description = "Glowing Fungus",
	tiles = {"caverealms_fungi.png"},
	inventory_image = "caverealms_fungi.png",
	wield_image = "caverealms_fungi.png",
	is_ground_content = true,
	groups = {oddly_breakable_by_hand=3},
	light_source = 5,
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
