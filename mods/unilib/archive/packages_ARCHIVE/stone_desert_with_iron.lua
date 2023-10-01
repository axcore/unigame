---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    darkage
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("darkage:desert_stone_with_iron", {
	description = "Desert Iron Ore",
	tiles = {"default_desert_stone.png^default_mineral_iron.png"},
	is_ground_content = true,
	groups = {cracky=3, not_cuttable=1},
	drop = 'default:iron_lump',
	sounds = default.node_sound_stone_defaults(),
})
]]--
