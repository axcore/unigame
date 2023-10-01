---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    valleys_c
-- Code:    GPL 3.0/BSD/WTFPL
-- Media:   GPL 3.0/BSD/WTFPL
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("valleys_c:glowing_fungal_stone", {
	description = "Glowing Fungal Stone",
	tiles = {"default_stone.png^vmg_glowing_fungal.png",},
	is_ground_content = true,
	light_source = 8,
	groups = {cracky=3, stone=1},
	drop = {items={ {items={"default:cobble"},}, {items={"valleys_c:glowing_fungus",},},},},
	sounds = default.node_sound_stone_defaults(),
})
]]--
