---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
--
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
--
-- From:    mtg_plus
-- Code:    MIT
-- Media:   CC-BY-SA 3.0/CC-BY 3.0/MIT
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
-- 'is ground content = false' to avoid tunnels in sea ice or ice rivers
minetest.register_node("default:ice", {
	description = S("Ice"),
	tiles = {"default_ice.png"},
	is_ground_content = false,
	paramtype = "light",
	groups = {cracky = 3, cools_lava = 1, slippery = 3},
	sounds = default.node_sound_ice_defaults(),
})
my_register_stair_and_slab(
	"ice",
	"default:ice",
	{cracky = 3, cools_lava = 1, slippery = 3},
	{"default_ice.png"},
	"Ice Stair",
	"Ice Slab",
	default.node_sound_ice_defaults(),
	true
)

-- Mapgen-placed ice with 'is ground content = true' to contain tunnels
minetest.register_node("default:cave_ice", {
	description = S("Cave Ice"),
	tiles = {"default_ice.png"},
	paramtype = "light",
	groups = {cracky = 3, cools_lava = 1, slippery = 3,
		not_in_creative_inventory = 1},
	drop = "default:ice",
	sounds = default.node_sound_ice_defaults(),
})
]]--

--[[
minetest.register_node("mtg_plus:ice_block", {
	description = S("Ice Block"),
	_doc_items_longdesc = build,
	tiles = {"mtg_plus_ice_block.png"},
	groups = {cracky = 3, cools_lava = 1, slippery = 3 },
	is_ground_content = false,
	paramtype = "light",
	sounds = default.node_sound_glass_defaults(),
})
minetest.register_craft({
	output = "mtg_plus:ice_block 9",
	recipe = { { "default:ice", "default:ice", "default:ice" },
	{ "default:ice", "default:ice", "default:ice" },
	{ "default:ice", "default:ice", "default:ice" } }
})
stairs.register_slab("ice_block", "mtg_plus:ice_block", {cracky=3, cools_lava=1, slippery=3}, {"mtg_plus_ice_block.png", "mtg_plus_ice_block.png", "mtg_plus_ice_block_slab.png", "mtg_plus_ice_block_slab.png", "mtg_plus_ice_block_slab.png", "mtg_plus_ice_block_slab.png"}, S("Ice Block Slab"), minetest.registered_items["mtg_plus:ice_block"].sounds)
stairs.register_stair("ice_block", "mtg_plus:ice_block", {cracky=3, cools_lava=1, slippery=3}, {"mtg_plus_ice_block_slab.png", "mtg_plus_ice_block.png", "mtg_plus_ice_block_stair1.png", "mtg_plus_ice_block_stair2.png", "mtg_plus_ice_block.png", "mtg_plus_ice_block_slab.png"}, S("Ice Block Stair"), minetest.registered_items["mtg_plus:ice_block"].sounds)
]]--

--[[
minetest.register_node("ethereal:icebrick", {
	description = S("Ice Brick"),
	tiles = {"ethereal_brick_ice.png"},
	paramtype = "light",
	freezemelt = "default:water_source",
	is_ground_content = false,
	groups = {cracky = 3, puts_out_fire = 1, cools_lava = 1},
	sounds = default.node_sound_glass_defaults()
})
minetest.register_craft({
	output = "ethereal:icebrick 4",
	recipe = {
		{"default:ice", "default:ice"},
		{"default:ice", "default:ice"}
	}
})
do_stair(
	"Ice Brick",
	"icebrick",
	"ethereal:icebrick",
	{cracky = 3, puts_out_fire = 1, cools_lava = 1},
	{"ethereal_brick_ice.png"},
	default.node_sound_glass_defaults())
]]--

--[[
minetest.register_node("mtg_plus:ice_tile4", {
	description = S("Ice Tile"),
	_doc_items_longdesc = build,
	tiles = {"mtg_plus_ice_tile4.png"},
	groups = {cracky = 3, level = 1, cools_lava = 1, slippery = 3 },
	is_ground_content = false,
	paramtype = "light",
	sounds = default.node_sound_glass_defaults(),
})
minetest.register_craft({
	output = "mtg_plus:ice_tile4",
	recipe = { { "mtg_plus:ice_block", "mtg_plus:ice_block" },
	{ "mtg_plus:ice_block", "mtg_plus:ice_block" },}
})
simple_stair_slab("ice_tile4", S("Ice Tile Stair"), S("Ice Tile Slab"))

minetest.register_node("mtg_plus:ice_tile16", {
	description = S("Dense Ice Tile"),
	_doc_items_longdesc = build,
	tiles = {"mtg_plus_ice_tile16.png"},
	groups = {cracky = 3, level = 2, cools_lava = 1, slippery = 2 },
	is_ground_content = false,
	sounds = default.node_sound_glass_defaults(),
})
minetest.register_craft({
	output = "mtg_plus:ice_tile16",
	recipe = { { "mtg_plus:ice_tile4", "mtg_plus:ice_tile4" },
	{ "mtg_plus:ice_tile4", "mtg_plus:ice_tile4" } }
})
walls.register("mtg_plus:wall_ice_tile16", S("Dense Ice Tile Wall"), "mtg_plus_ice_tile16.png", "mtg_plus:ice_tile16", default.node_sound_glass_defaults())
]]--
