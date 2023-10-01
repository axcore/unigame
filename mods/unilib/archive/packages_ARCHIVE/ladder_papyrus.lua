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
minetest.register_node("mtg_plus:ladder_papyrus", {
	description = S("Papyrus Ladder"),
	_doc_items_longdesc = S("A particulary strong piece of ladder which allows you to move vertically."),
	drawtype = "signlike",
	tiles = {"mtg_plus_ladder_papyrus.png"},
	inventory_image = "mtg_plus_ladder_papyrus.png",
	wield_image = "mtg_plus_ladder_papyrus.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	climbable = true,
	is_ground_content = false,
	selection_box = { type = "wallmounted", },
	groups = { snappy = 2, choppy = 1, flammable = 2 },
	sounds = default.node_sound_leaves_defaults(),
})
minetest.register_craft({
	output = "mtg_plus:ladder_papyrus 2",
	recipe = { {"default:papyrus", "", "default:papyrus"},
	{"farming:string", "default:papyrus", "farming:string"},
	{"default:papyrus", "", "default:papyrus"}},
})
minetest.register_craft({
	type = "fuel",
	recipe = "mtg_plus:ladder_papyrus",
	burntime = 2,
})
]]--
