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
minetest.register_node("castle_masonry:rubble", {
	description = S("Castle Rubble"),
	drawtype = "normal",
	tiles = {"castle_rubble.png"},
	paramtype = "light",
	groups = {crumbly=3,falling_node=1},
	sounds = default.node_sound_gravel_defaults(),
})
minetest.register_craft({
	output = "castle_masonry:rubble",
	recipe = {
		{"castle_masonry:stonewall"},
	}
})
minetest.register_craft({
	output = "castle_masonry:rubble 2",
	recipe = {
		{"default:gravel"},
		{"default:desert_stone"},
	}
})
]]--
