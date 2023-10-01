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
minetest.register_node("mtg_plus:obsidianbrick_gold", {
	description = S("Obsidian Brick with Golden Edges"),
	_doc_items_longdesc = build,
	tiles = {"mtg_plus_obsidian_brick_gold.png"},
	is_ground_content = false,
	groups = { cracky = 1, level = 2 },
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_craft({
	output = "mtg_plus:obsidianbrick_gold 4",
	recipe = { { "", "default:obsidianbrick", "", },
	{ "default:obsidianbrick", "default:gold_ingot", "default:obsidianbrick", },
	{ "", "default:obsidianbrick", "", } }
})
]]--
