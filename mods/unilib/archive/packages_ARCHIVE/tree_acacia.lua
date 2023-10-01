---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
--
-- From:    doors
-- Code:    MIT
-- Media:   CC BY-SA 3.0
--
-- From:    moreblocks
-- Code:    zlib
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("default:acacia_tree", {
	description = S("Acacia Tree"),
	tiles = {"default_acacia_tree_top.png", "default_acacia_tree_top.png",
		"default_acacia_tree.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults(),

	on_place = minetest.rotate_node
})
minetest.register_craft({
	type = "fuel",
	recipe = "default:acacia_tree",
	burntime = 34,
})

minetest.register_node("default:acacia_wood", {
	description = S("Acacia Wood Planks"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"default_acacia_wood.png"},
	is_ground_content = false,
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, wood = 1},
	sounds = default.node_sound_wood_defaults(),
})
minetest.register_craft({
	output = "default:acacia_wood 4",
	recipe = {
		{"default:acacia_tree"},
	}
})
minetest.register_craft({
	type = "fuel",
	recipe = "default:acacia_wood",
	burntime = 8,
})
my_register_stair_and_slab(
	"acacia_wood",
	"default:acacia_wood",
	{choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
	{"default_acacia_wood.png"},
	"Acacia Wood Stair",
	"Acacia Wood Slab",
	default.node_sound_wood_defaults(),
	false
)

minetest.register_node("default:acacia_leaves", {
	description = S("Acacia Tree Leaves"),
	drawtype = "allfaces_optional",
	tiles = {"default_acacia_leaves.png"},
	special_tiles = {"default_acacia_leaves_simple.png"},
	waving = 1,
	paramtype = "light",
	is_ground_content = false,
	groups = {snappy = 3, leafdecay = 3, flammable = 2, leaves = 1},
	drop = {
		max_items = 1,
		items = {
			{items = {"default:acacia_sapling"}, rarity = 20},
			{items = {"default:acacia_leaves"}}
		}
	},
	sounds = default.node_sound_leaves_defaults(),

	after_place_node = after_place_leaves,
})
default.register_leafdecay({
	trunks = {"default:acacia_tree"},
	leaves = {"default:acacia_leaves"},
	radius = 2,
})

minetest.register_node("default:acacia_sapling", {
	description = S("Acacia Tree Sapling"),
	drawtype = "plantlike",
	tiles = {"default_acacia_sapling.png"},
	inventory_image = "default_acacia_sapling.png",
	wield_image = "default_acacia_sapling.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	on_timer = grow_sapling,
	selection_box = {
		type = "fixed",
		fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16}
	},
	groups = {snappy = 2, dig_immediate = 3, flammable = 2,
		attached_node = 1, sapling = 1},
	sounds = default.node_sound_leaves_defaults(),

	on_construct = function(pos)
		minetest.get_node_timer(pos):start(math.random(300, 1500))
	end,

	on_place = function(itemstack, placer, pointed_thing)
		itemstack = default.sapling_on_place(itemstack, placer, pointed_thing,
			"default:acacia_sapling",
			-- minp, maxp to be checked, relative to sapling pos
			-- minp_relative.y = 1 because sapling pos has been checked
			{x = -4, y = 1, z = -4},
			{x = 4, y = 7, z = 4},
			-- maximum interval of interior volume check
			4)

		return itemstack
	end,
})
minetest.register_craft({
	type = "fuel",
	recipe = "default:acacia_sapling",
	burntime = 6,
})

function default.grow_new_acacia_tree(pos)
	local path = minetest.get_modpath("default") ..
		"/schematics/acacia_tree_from_sapling.mts"
	minetest.place_schematic({x = pos.x - 4, y = pos.y - 1, z = pos.z - 4},
		path, "random", nil, false)
end

local nodes = {
	["all_faces_acacia_tree"] = {
		description = S("All-faces Acacia Tree"),
		tiles = {"default_acacia_tree_top.png"},
		groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
		sounds = sound_wood,
		furnace_burntime = 34,
	},
}
minetest.register_craft({
	output = "moreblocks:all_faces_acacia_tree 8",
	recipe = {
		{"default:acacia_tree", "default:acacia_tree", "default:acacia_tree"},
		{"default:acacia_tree", "", "default:acacia_tree"},
		{"default:acacia_tree", "default:acacia_tree", "default:acacia_tree"},
	}
})

default.register_fence("default:fence_acacia_wood", {
	description = S("Acacia Wood Fence"),
	texture = "default_fence_acacia_wood.png",
	inventory_image = "default_fence_overlay.png^default_acacia_wood.png^" ..
				"default_fence_overlay.png^[makealpha:255,126,126",
	wield_image = "default_fence_overlay.png^default_acacia_wood.png^" ..
				"default_fence_overlay.png^[makealpha:255,126,126",
	material = "default:acacia_wood",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
	sounds = default.node_sound_wood_defaults()
})
minetest.register_craft({
	type = "fuel",
	recipe = "default:fence_acacia_wood",
	burntime = 8,
})

default.register_fence_rail("default:fence_rail_acacia_wood", {
    description = S("Acacia Wood Fence Rail"),
    texture = "default_fence_rail_acacia_wood.png",
    inventory_image = "default_fence_rail_overlay.png^default_acacia_wood.png^" ..
                "default_fence_rail_overlay.png^[makealpha:255,126,126",
    wield_image = "default_fence_rail_overlay.png^default_acacia_wood.png^" ..
                "default_fence_rail_overlay.png^[makealpha:255,126,126",
    material = "default:acacia_wood",
    groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
    sounds = default.node_sound_wood_defaults()
})
minetest.register_craft({
	type = "fuel",
	recipe = "default:fence_rail_acacia_wood",
	burntime = 6,
})

doors.register_fencegate("doors:gate_acacia_wood", {
	description = S("Acacia Wood Fence Gate"),
	texture = "default_acacia_wood.png",
	material = "default:acacia_wood",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2}
})
minetest.register_craft({
	type = "fuel",
	recipe = "doors:gate_acacia_wood_closed",
	burntime = 8,
})

minetest.register_decoration({
    name = "default:acacia_tree",
    deco_type = "schematic",
    place_on = {"default:dry_dirt_with_dry_grass"},
    sidelen = 16,
    noise_params = {
        offset = 0,
        scale = 0.002,
        spread = {x = 250, y = 250, z = 250},
        seed = 2,
        octaves = 3,
        persist = 0.66
    },
    biomes = {"savanna"},
    y_max = 31000,
    y_min = 1,
    schematic = minetest.get_modpath("default") .. "/schematics/acacia_tree.mts",
    flags = "place_center_x, place_center_z",
    rotation = "random",
})

minetest.register_decoration({
    name = "default:acacia_log",
    deco_type = "schematic",
    place_on = {"default:dry_dirt_with_dry_grass"},
    place_offset_y = 1,
    sidelen = 16,
    noise_params = {
        offset = 0,
        scale = 0.001,
        spread = {x = 250, y = 250, z = 250},
        seed = 2,
        octaves = 3,
        persist = 0.66
    },
    biomes = {"savanna"},
    y_max = 31000,
    y_min = 1,
    schematic = minetest.get_modpath("default") .. "/schematics/acacia_log.mts",
    flags = "place_center_x",
    rotation = "random",
    spawn_by = "default:dry_dirt_with_dry_grass",
    num_spawn_by = 8,
})
]]--
