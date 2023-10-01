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
minetest.register_node("mtg_plus:jungle_cobble", {
	description = S("Jungle Cobblestone"),
	_doc_items_longdesc = build,
	tiles = {"mtg_plus_jungle_cobble.png"},
	groups = {cracky=3, stone=1},
	is_ground_content = false,
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_craft({
	output = "mtg_plus:jungle_cobble",
	type = "shapeless",
	recipe = { "default:jungleleaves", "default:jungleleaves", "default:cobble" },
})
minetest.register_craft({
	output = "mtg_plus:jungle_cobble",
	type = "shapeless",
	recipe = { "default:jungleleaves", "default:mossycobble" },
})
minetest.register_craft({
	output = "default:stone",
	type = "cooking",
	recipe = "mtg_plus:jungle_cobble",
})
simple_stair_slab("jungle_cobble", S("Jungle Cobblestone Stair"), S("Jungle Cobblestone Slab"))
walls.register("mtg_plus:wall_jungle_cobble", S("Jungle Cobblestone Wall"), "mtg_plus_jungle_cobble.png", "mtg_plus:jungle_cobble", default.node_sound_stone_defaults())
]]--
