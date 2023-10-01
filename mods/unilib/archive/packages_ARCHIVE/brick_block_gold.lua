---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    mtg_plus
-- Code:    MIT
-- Media:   CC-BY-SA 3.0/CC-BY 3.0/MIT
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("mtg_plus:goldbrick", {
	description = S("Gold Brick"),
	_doc_items_longdesc = build,
	tiles = {"mtg_plus_gold_brick.png"},
	is_ground_content = false,
	groups = { cracky = 1, },
	sounds = metal_sounds,
})
minetest.register_craft({
	output = "mtg_plus:goldbrick 4",
	recipe = { { "default:goldblock", "default:goldblock", },
	{ "default:goldblock", "default:goldblock", }, },
})
simple_stair_slab("goldbrick", S("Gold Brick Stair"), S("Gold Brick Slab"))
]]--
