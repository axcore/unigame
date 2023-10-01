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
minetest.register_node("castle_masonry:dungeon_stone", {
	description = S("Dungeon Stone"),
	drawtype = "normal",
	tiles = {"castle_dungeon_stone.png"},
	groups = {cracky=2},
	paramtype = "light",
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_craft({
	output = "castle_masonry:dungeon_stone 2",
	recipe = {
		{"default:stonebrick", "default:obsidian"},
	}
})
minetest.register_craft({
	output = "castle_masonry:dungeon_stone 2",
	recipe = {
		{"default:stonebrick"},
		{"default:obsidian"},
	}
})
]]--
