---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
--
-- From:    mtg_plus
-- Code:    MIT
-- Media:   CC-BY-SA 3.0/CC-BY 3.0/MIT
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_craftitem("default:diamond", {
	description = S("Diamond"),
	inventory_image = "default_diamond.png",
})
minetest.register_craft({
	output = "default:diamond 9",
	recipe = {
		{"default:diamondblock"},
	}
})

minetest.register_node("default:diamondblock", {
	description = S("Diamond Block"),
	tiles = {"default_diamond_block.png"},
	is_ground_content = false,
	groups = {cracky = 1, level = 3},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_craft({
	output = "default:diamondblock",
	recipe = {
		{"default:diamond", "default:diamond", "default:diamond"},
		{"default:diamond", "default:diamond", "default:diamond"},
		{"default:diamond", "default:diamond", "default:diamond"},
	}
})

minetest.register_node("mtg_plus:gold_diamond_block", {
	description = S("Small Gold-framed Diamond Block"),
	_doc_items_longdesc = deco,
	tiles = {"mtg_plus_gold_diamond_block.png"},
	is_ground_content = false,
	groups = {cracky = 1, level = 3},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_craft({
	output = "mtg_plus:gold_diamond_block",
	recipe = { { "default:gold_ingot", "default:diamond", "default:gold_ingot", },
	{ "default:diamond", "default:diamond", "default:diamond" },
	{ "default:gold_ingot", "default:diamond", "default:gold_ingot", } },
})

minetest.register_node("mtg_plus:harddiamondblock",{
	description = S("Aggregated Diamond Block"),
	_doc_items_longdesc = S("This block is even harder than diamond; diamond pickaxes can't break it. TNT is able to destroy this block."),
	tiles = { "mtg_plus_hard_diamond_block.png" },
	is_ground_content = false,
	groups = { cracky = 1, level = 4 },
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_craft({
	output = "mtg_plus:harddiamondblock 1",
	type = "shapeless",
	recipe = { "default:diamondblock", "default:diamondblock" }
})
]]--
