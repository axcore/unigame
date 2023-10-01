---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
--
-- From:    gravelcraft
-- Code:    MIT
-- Media:   n/a
--
-- From:    mtg_plus
-- Code:    MIT
-- Media:   CC-BY-SA 3.0/CC-BY 3.0/MIT
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("default:gravel", {
	description = S("Gravel"),
	tiles = {"default_gravel.png"},
	groups = {crumbly = 2, falling_node = 1},
	sounds = default.node_sound_gravel_defaults(),
	drop = {
		max_items = 1,
		items = {
			{items = {"default:flint"}, rarity = 16},
			{items = {"default:gravel"}}
		}
	}
})
]]--

--[[
minetest.register_node("mtg_plus:gravel_cobble", {
	description = S("Cobbled Gravel"),
	_doc_items_longdesc = S("Cobbled gravel is solidified gravel, carefully arranged in a mosaic-like pattern. It makes a nice building material."),
	tiles = {"mtg_plus_gravel_cobble.png"},
	is_ground_content = false,
	groups = { cracky = 3, stone = 1 },
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_craft({
	output = "mtg_plus:gravel_cobble 2",
	recipe = { { "default:gravel", "default:gravel" },
		{ "default:gravel", "default:gravel" } },
})
minetest.register_craft({
	type = "cooking",
	output = "default:gravel",
	recipe = "mtg_plus:gravel_cobble",
})
simple_stair_slab("gravel_cobble", S("Cobbled Gravel Stair"), S("Cobbled Gravel Slab"))
walls.register("mtg_plus:wall_gravel_cobble", S("Cobbled Gravel Wall"), "mtg_plus_gravel_cobble.png", "mtg_plus:gravel_cobble", default.node_sound_stone_defaults())
]]--
