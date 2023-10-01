---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("mapgen:icicle", {
	description = "Icicle",
	drawtype = "plantlike",
	tiles = {"mapgen_icicle.png"},
	inventory_image = "mapgen_icicle.png",
	is_ground_content = false,
	sunlight_propagates = true,
	paramtype = "light",
	selection_box = {
	type = "fixed",
	fixed = {{-0.3, -0.2, -0.3, 0.3, 0.5, 0.3}}
	},
	walkable = false,
	groups = {crumbly=1, oddly_breakable_by_hand=1},
	sounds = default.node_sound_glass_defaults(),
})
]]--
