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
minetest.register_node("castle_masonry:stonewall_corner", {
	drawtype = "normal",
	paramtype = "light",
	paramtype2 = "facedir",
	description = S("Castle Corner"),
	tiles = {"castle_corner_stonewall_tb.png^[transformR90",
		 "castle_corner_stonewall_tb.png^[transformR180",
		 "castle_corner_stonewall1.png",
		 "castle_stonewall.png",
		 "castle_stonewall.png",	
		 "castle_corner_stonewall2.png"},
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_craft({
	output = "castle_masonry:stonewall_corner",
	recipe = {
		{"", "castle_masonry:stonewall"},
		{"castle_masonry:stonewall", "default:sandstone"},
	}
})
]]--
