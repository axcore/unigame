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
minetest.register_node("mtg_plus:steelbrick", {
	description = S("Steel Brick"),
	_doc_items_longdesc = build,
	tiles = {"mtg_plus_steel_brick.png"},
	is_ground_content = false,
	groups = { cracky = 1, level = 2 },
	sounds = metal_sounds,
})
minetest.register_craft({
	output = "mtg_plus:steelbrick 4",
	recipe = { { "default:steelblock", "default:steelblock", },
	{ "default:steelblock", "default:steelblock", }, },
})
simple_stair_slab("steelbrick", S("Steel Brick Stair"), S("Steel Brick Slab"))
]]--
