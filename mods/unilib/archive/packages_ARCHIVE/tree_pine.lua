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
minetest.register_node("default:pine_tree", {
	description = S("Pine Tree"),
	tiles = {"default_pine_tree_top.png", "default_pine_tree_top.png",
		"default_pine_tree.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {tree = 1, choppy = 3, oddly_breakable_by_hand = 1, flammable = 3},
	sounds = default.node_sound_wood_defaults(),

	on_place = minetest.rotate_node
})
minetest.register_craft({
	type = "fuel",
	recipe = "default:pine_tree",
	burntime = 26,
})

minetest.register_node("default:pine_wood", {
	description = S("Pine Wood Planks"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"default_pine_wood.png"},
	is_ground_content = false,
	groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3, wood = 1},
	sounds = default.node_sound_wood_defaults(),
})
minetest.register_craft({
	output = "default:pine_wood 4",
	recipe = {
		{"default:pine_tree"},
	}
})
minetest.register_craft({
	type = "fuel",
	recipe = "default:pine_wood",
	burntime = 6,
})
my_register_stair_and_slab(
	"pine_wood",
	"default:pine_wood",
	{choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	{"default_pine_wood.png"},
	"Pine Wood Stair",
	"Pine Wood Slab",
	default.node_sound_wood_defaults(),
	false
)

minetest.register_node("default:pine_needles",{
	description = S("Pine Needles"),
	drawtype = "allfaces_optional",
	tiles = {"default_pine_needles.png"},
	waving = 1,
	paramtype = "light",
	is_ground_content = false,
	groups = {snappy = 3, leafdecay = 3, flammable = 2, leaves = 1},
	drop = {
		max_items = 1,
		items = {
			{items = {"default:pine_sapling"}, rarity = 20},
			{items = {"default:pine_needles"}}
		}
	},
	sounds = default.node_sound_leaves_defaults(),

	after_place_node = after_place_leaves,
})
default.register_leafdecay({
	trunks = {"default:pine_tree"},
	leaves = {"default:pine_needles"},
	radius = 3,
})

minetest.register_node("default:pine_sapling", {
	description = S("Pine Tree Sapling"),
	drawtype = "plantlike",
	tiles = {"default_pine_sapling.png"},
	inventory_image = "default_pine_sapling.png",
	wield_image = "default_pine_sapling.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	on_timer = grow_sapling,
	selection_box = {
		type = "fixed",
		fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16}
	},
	groups = {snappy = 2, dig_immediate = 3, flammable = 3,
		attached_node = 1, sapling = 1},
	sounds = default.node_sound_leaves_defaults(),

	on_construct = function(pos)
		minetest.get_node_timer(pos):start(math.random(300, 1500))
	end,

	on_place = function(itemstack, placer, pointed_thing)
		itemstack = default.sapling_on_place(itemstack, placer, pointed_thing,
			"default:pine_sapling",
			-- minp, maxp to be checked, relative to sapling pos
			-- minp_relative.y = 1 because sapling pos has been checked
			{x = -2, y = 1, z = -2},
			{x = 2, y = 14, z = 2},
			-- maximum interval of interior volume check
			4)

		return itemstack
	end,
})
minetest.register_craft({
	type = "fuel",
	recipe = "default:pine_sapling",
	burntime = 5,
})

-- New pine tree
function default.grow_new_pine_tree(pos)
	local path
	if math.random() > 0.5 then
		path = minetest.get_modpath("default") ..
			"/schematics/pine_tree_from_sapling.mts"
	else
		path = minetest.get_modpath("default") ..
			"/schematics/small_pine_tree_from_sapling.mts"
	end
	minetest.place_schematic({x = pos.x - 2, y = pos.y - 1, z = pos.z - 2},
		path, "0", nil, false)
end

-- New snowy pine tree
function default.grow_new_snowy_pine_tree(pos)
	local path
	if math.random() > 0.5 then
		path = minetest.get_modpath("default") ..
			"/schematics/snowy_pine_tree_from_sapling.mts"
	else
		path = minetest.get_modpath("default") ..
			"/schematics/snowy_small_pine_tree_from_sapling.mts"
	end
	minetest.place_schematic({x = pos.x - 2, y = pos.y - 1, z = pos.z - 2},
		path, "random", nil, false)
end

local nodes = {
	["all_faces_pine_tree"] = {
		description = S("All-faces Pine Tree"),
		tiles = {"default_pine_tree_top.png"},
		groups = {tree = 1, choppy = 3, oddly_breakable_by_hand = 1, flammable = 3},
		sounds = sound_wood,
		furnace_burntime = 26,
	},
}
minetest.register_craft({
	output = "moreblocks:all_faces_pine_tree 8",
	recipe = {
		{"default:pine_tree", "default:pine_tree", "default:pine_tree"},
		{"default:pine_tree", "", "default:pine_tree"},
		{"default:pine_tree", "default:pine_tree", "default:pine_tree"},
	}
})

default.register_fence("default:fence_pine_wood", {
	description = S("Pine Wood Fence"),
	texture = "default_fence_pine_wood.png",
	inventory_image = "default_fence_overlay.png^default_pine_wood.png^" ..
				"default_fence_overlay.png^[makealpha:255,126,126",
	wield_image = "default_fence_overlay.png^default_pine_wood.png^" ..
				"default_fence_overlay.png^[makealpha:255,126,126",
	material = "default:pine_wood",
	groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	sounds = default.node_sound_wood_defaults()
})
minetest.register_craft({
	type = "fuel",
	recipe = "default:fence_pine_wood",
	burntime = 6,
})

default.register_fence_rail("default:fence_rail_pine_wood", {
	description = S("Pine Wood Fence Rail"),
	texture = "default_fence_rail_pine_wood.png",
	inventory_image = "default_fence_rail_overlay.png^default_pine_wood.png^" ..
				"default_fence_rail_overlay.png^[makealpha:255,126,126",
	wield_image = "default_fence_rail_overlay.png^default_pine_wood.png^" ..
				"default_fence_rail_overlay.png^[makealpha:255,126,126",
	material = "default:pine_wood",
	groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	sounds = default.node_sound_wood_defaults()
})
minetest.register_craft({
	type = "fuel",
	recipe = "default:fence_rail_pine_wood",
	burntime = 4,
})

doors.register_fencegate("doors:gate_pine_wood", {
	description = S("Pine Wood Fence Gate"),
	texture = "default_pine_wood.png",
	material = "default:pine_wood",
	groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3}
})
minetest.register_craft({
	type = "fuel",
	recipe = "doors:gate_pine_wood_closed",
	burntime = 6,
})

minetest.register_decoration({
    name = "default:pine_tree",
    deco_type = "schematic",
    place_on = {"default:dirt_with_snow", "default:dirt_with_coniferous_litter"},
    sidelen = 16,
    noise_params = {
        offset = 0.010,
        scale = 0.048,
        spread = {x = 250, y = 250, z = 250},
        seed = 2,
        octaves = 3,
        persist = 0.66
    },
    biomes = {"taiga", "coniferous_forest"},
    y_max = 31000,
    y_min = 4,
    schematic = minetest.get_modpath("default") .. "/schematics/pine_tree.mts",
    flags = "place_center_x, place_center_z",
})

minetest.register_decoration({
    name = "default:small_pine_tree",
    deco_type = "schematic",
    place_on = {"default:dirt_with_snow", "default:dirt_with_coniferous_litter"},
    sidelen = 16,
    noise_params = {
        offset = 0.010,
        scale = -0.048,
        spread = {x = 250, y = 250, z = 250},
        seed = 2,
        octaves = 3,
        persist = 0.66
    },
    biomes = {"taiga", "coniferous_forest"},
    y_max = 31000,
    y_min = 4,
    schematic = minetest.get_modpath("default") .. "/schematics/small_pine_tree.mts",
    flags = "place_center_x, place_center_z",
})

minetest.register_decoration({
    name = "default:pine_log",
    deco_type = "schematic",
    place_on = {"default:dirt_with_snow", "default:dirt_with_coniferous_litter"},
    place_offset_y = 1,
    sidelen = 80,
    fill_ratio = 0.0018,
    biomes = {"taiga", "coniferous_forest"},
    y_max = 31000,
    y_min = 4,
    schematic = minetest.get_modpath("default") .. "/schematics/pine_log.mts",
    flags = "place_center_x",
    rotation = "random",
    spawn_by = {"default:dirt_with_snow", "default:dirt_with_coniferous_litter"},
    num_spawn_by = 8,
})
]]--
