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
minetest.register_node("mtg_plus:goldwood", {
	description = S("Goldwood"),
	_doc_items_longdesc = S("Goldwood is a precious artificial kind of wood made by enriching wood with gold. Goldwood is fireproof and notable for its bright yellowy appearance."),
	tiles = {"mtg_plus_goldwood.png"},
	is_ground_content = false,
	groups = {choppy = 2, wood = 1},
	sounds = default.node_sound_wood_defaults(),
})
minetest.register_craft({
	output = "mtg_plus:goldwood",
	type = "shapeless",
	recipe = { "group:wood", "default:gold_ingot" },
})
-- Prevent goldwood from being used as furnace fuel
minetest.clear_craft({
	type = "fuel",
	recipe = "mtg_plus:goldwood",
})
simple_stair_slab("goldwood", S("Goldwood Stair"), S("Goldwood Slab"))

default.register_fence("mtg_plus:fence_goldwood", {
	description = S("Goldwood Fence"),
	_doc_items_longdesc = S("This is a fence made out of precious goldwood. The fence will neatly connect to its neighbors, making it easy to build nice-looking fence structures. The fence can be jumped over."),
	texture = "mtg_plus_goldwood.png",
	material = "mtg_plus:goldwood",
	sounds = minetest.registered_nodes["mtg_plus:goldwood"].sounds,
	groups = {choppy=2, },
})

default.register_fence_rail("mtg_plus:fence_rail_goldwood", {
	description = S("Goldwood Fence Rail"),
	_doc_items_longdesc = S("This is a fence rail made out of precious goldwood. It will neatly connect to its neighbors, but without creating fence posts. It can be jumped over."),
	texture = "mtg_plus_fence_rail_goldwood.png",
	inventory_image = "default_fence_rail_overlay.png^mtg_plus_goldwood.png^" ..
		"default_fence_rail_overlay.png^[makealpha:255,126,126",
	wield_image = "default_fence_rail_overlay.png^mtg_plus_goldwood.png^" ..
		"default_fence_rail_overlay.png^[makealpha:255,126,126",
	material = "mtg_plus:goldwood",
	groups = {choppy = 2, },
	sounds = minetest.registered_nodes["mtg_plus:goldwood"].sounds,
})

doors.register_fencegate("mtg_plus:gate_goldwood", {
	description = S("Goldwood Fence Gate"),
	material = "mtg_plus:goldwood",
	texture = "mtg_plus_goldwood.png",
	groups = {choppy=2, },
})
]]--
