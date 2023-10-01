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
minetest.register_node("mtg_plus:desert_sandstone_brick_gold", {
	description = S("Desert Sandstone Brick with Golden Edges"),
	_doc_items_longdesc = build,
	tiles = {"mtg_plus_desert_sandstone_brick_gold.png"},
	is_ground_content = false,
	groups = { cracky = 2, },
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_craft({
	output = "mtg_plus:desert_sandstone_brick_gold 4",
	recipe = { { "", "default:desert_sandstone_brick", "", },
	{ "default:desert_sandstone_brick", "default:gold_ingot", "default:desert_sandstone_brick", },
	{ "", "default:desert_sandstone_brick", "", } }
})
]]--
