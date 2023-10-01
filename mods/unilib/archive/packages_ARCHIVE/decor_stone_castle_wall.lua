---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    castle/castle_masonry
-- Code:    MIT
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("castle_masonry:stonewall", {
	description = S("Castle Wall"),
	drawtype = "normal",
	tiles = {"castle_stonewall.png"},
	paramtype = "light",
	drop = "castle_masonry:stonewall",
	groups = {cracky=3},
	sunlight_propagates = false,
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_craft({
	output = "castle_masonry:stonewall",
	recipe = {
		{"default:cobble"},
		{"default:desert_stone"},
	}
})
]]--
