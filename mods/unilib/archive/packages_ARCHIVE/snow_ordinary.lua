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
minetest.register_node("default:snow", {
	description = S("Snow"),
	tiles = {"default_snow.png"},
	inventory_image = "default_snowball.png",
	wield_image = "default_snowball.png",
	paramtype = "light",
	buildable_to = true,
	floodable = true,
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.25, 0.5},
		},
	},
	collision_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -6 / 16, 0.5},
		},
	},
	groups = {crumbly = 3, falling_node = 1, snowy = 1},
	sounds = default.node_sound_snow_defaults(),

	on_construct = function(pos)
		pos.y = pos.y - 1
		if minetest.get_node(pos).name == "default:dirt_with_grass" then
			minetest.set_node(pos, {name = "default:dirt_with_snow"})
		end
	end,
})
minetest.register_craft({
	output = "default:snow 9",
	recipe = {
		{"default:snowblock"},
	}
})

-- Tundra patchy snow
minetest.register_decoration({
    deco_type = "simple",
    place_on = {
        "default:permafrost_with_moss",
        "default:permafrost_with_stones",
        "default:stone",
        "default:gravel"
    },
    sidelen = 4,
    noise_params = {
        offset = 0,
        scale = 1.0,
        spread = {x = 100, y = 100, z = 100},
        seed = 172555,
        octaves = 3,
        persist = 1.0
    },
    biomes = {"tundra", "tundra_beach"},
    y_max = 50,
    y_min = 1,
    decoration = "default:snow",
})

minetest.register_node("default:snowblock", {
	description = S("Snow Block"),
	tiles = {"default_snow.png"},
	groups = {crumbly = 3, cools_lava = 1, snowy = 1},
	sounds = default.node_sound_snow_defaults(),

	on_construct = function(pos)
		pos.y = pos.y - 1
		if minetest.get_node(pos).name == "default:dirt_with_grass" then
			minetest.set_node(pos, {name = "default:dirt_with_snow"})
		end
	end,
})
minetest.register_craft({
	output = "default:snowblock",
	recipe = {
		{"default:snow", "default:snow", "default:snow"},
		{"default:snow", "default:snow", "default:snow"},
		{"default:snow", "default:snow", "default:snow"},
	}
})
my_register_stair_and_slab(
	"snowblock",
	"default:snowblock",
	{crumbly = 3, cools_lava = 1, snowy = 1},
	{"default_snow.png"},
	"Snow Block Stair",
	"Snow Block Slab",
	default.node_sound_snow_defaults(),
	true
)
]]--

--[[
minetest.register_node("ethereal:snowbrick", {
	description = S("Snow Brick"),
	tiles = {"ethereal_brick_snow.png"},
	paramtype = "light",
	freezemelt = "default:water_source",
	is_ground_content = false,
	groups = {crumbly = 3, puts_out_fire = 1, cools_lava = 1},
	sounds = default.node_sound_dirt_defaults({
		footstep = {name = "default_snow_footstep", gain = 0.15},
		dug = {name = "default_snow_footstep", gain = 0.2},
		dig = {name = "default_snow_footstep", gain = 0.2}
	})
})
minetest.register_craft({
	output = "ethereal:snowbrick 4",
	recipe = {
		{"default:snowblock", "default:snowblock"},
		{"default:snowblock", "default:snowblock"}
	}
})
do_stair(
	"Snow Brick",
	"snowbrick",
	"ethereal:snowbrick",
	{crumbly = 3, puts_out_fire = 1, cools_lava = 1},
	{"ethereal_brick_snow.png"},
	default.node_sound_dirt_defaults({
		footstep = {name = "default_snow_footstep", gain = 0.25},
		dug = {name = "default_snow_footstep", gain = 0.75},
	}))
]]--

--[[
minetest.register_node("mtg_plus:snow_brick", {
	description = S("Soft Snow Brick"),
	_doc_items_longdesc = build,
	tiles = {"mtg_plus_snow_brick.png"},
	groups = {crumbly = 2, cools_lava = 1, snowy = 1},
	is_ground_content = false,
	sounds = default.node_sound_dirt_defaults({
		footstep={name="default_snow_footstep", gain = 0.15},
		dig={name="default_snow_footstep", gain = 0.2},
		dug={name="default_snow_footstep", gain = 0.2}
	}),
})
minetest.register_craft({
	output = "mtg_plus:snow_brick 4",
	recipe = { { "default:snowblock", "default:snowblock" },
	{ "default:snowblock", "default:snowblock", } },
})
minetest.register_craft({
	output = "default:snowblock 4",
	recipe = { { "mtg_plus:snow_brick" } },
})
simple_stair_slab("snow_brick", S("Soft Snow Brick Stair"), S("Soft Snow Brick Slab"))

minetest.register_node("mtg_plus:hard_snow_brick", {
	description = S("Hard Snow Brick"),
	_doc_items_longdesc = build,
	tiles = {"mtg_plus_hard_snow_brick.png"},
	groups = {crumbly = 1, cracky = 2, cools_lava = 1, snowy = 1},
	is_ground_content = false,
	sounds = default.node_sound_dirt_defaults({
		dig={name="default_snow_footstep", gain = 0.2},
		dug={name="default_snow_footstep", gain = 0.2}
	}),
})
minetest.register_craft({
	output = "mtg_plus:hard_snow_brick",
	recipe = { { "mtg_plus:snow_brick", "mtg_plus:snow_brick" },
		{  "mtg_plus:snow_brick", "mtg_plus:snow_brick" } },
})
simple_stair_slab("hard_snow_brick", S("Hard Snow Brick Stair"), S("Hard Snow Brick Slab"))

minetest.register_node("mtg_plus:ice_snow_brick", {
	description = S("Icy Snow Brick"),
	_doc_items_longdesc = build,
	tiles = {"mtg_plus_ice_snow_brick.png"},
	groups = {cracky = 2, cools_lava = 1, slippery=1},
	is_ground_content = false,
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_craft({
	output = "mtg_plus:ice_snow_brick 2",
	type = "shapeless",
	recipe = { "mtg_plus:hard_snow_brick", "mtg_plus:ice_brick" },
})
simple_stair_slab("ice_snow_brick", S("Icy Snow Brick Stair"), S("Icy Snow Brick Slab"))
]]--
