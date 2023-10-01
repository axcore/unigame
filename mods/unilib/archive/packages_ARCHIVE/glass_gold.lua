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
minetest.register_node("mtg_plus:goldglass", {
	description = S("Goldglass"),
	_doc_items_longdesc = S("A ornamental and mostly transparent block, made by combining glass with gold."),
	drawtype = "glasslike_framed_optional",
	tiles = {"mtg_plus_goldglass.png", "mtg_plus_goldglass_detail.png"},
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
	groups = { cracky = 3, oddly_breakable_by_hand = 2},
	sounds = default.node_sound_glass_defaults(),
})
minetest.register_craft({
	output = "mtg_plus:goldglass 1",
	recipe = { { "default:gold_ingot", },
		{ "default:glass",},
		{ "default:gold_ingot", },
	}
})
]]--
