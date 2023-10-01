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
minetest.register_node("castle_masonry:pavement_brick", {
	description = S("Paving Stone"),
	drawtype = "normal",
	tiles = {"castle_pavement_brick.png"},
	groups = {cracky=2},
	paramtype = "light",
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_craft({
	output = "castle_masonry:pavement_brick 4",
	recipe = {
		{"default:stone", "default:cobble"},
		{"default:cobble", "default:stone"},
	}
})
]]--
