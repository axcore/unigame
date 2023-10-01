---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("mapgen:baobab_tree", {
	description = "Baobab tree",
	tiles = {
		"mapgen_baobab_tree_top.png",
		"mapgen_baobab_tree_top.png",
		"mapgen_baobab_tree.png",
	},
	groups = {choppy = 2, tree = 1, flammable = 1, oddly_breakable_by_hand=1},
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir",
	on_place = minetest.rotate_node
})

minetest.register_node("mapgen:baobab_wood", {
	description = "Baobab wood Planks",
	tiles = {
		"mapgen_baobab_wood.png",
	},
	groups = {choppy = 1, flammable = 1, oddly_breakable_by_hand=1, wood=1},
	sounds = default.node_sound_wood_defaults()
})
minetest.register_craft( {
	output = "mapgen:baobab_wood 4",
	recipe = {
		{ "mapgen:baobab_tree",},
	}
})

minetest.register_node("mapgen:baobab_leaves", {
	description = "Baobab Leaves",
	drawtype = "allfaces_optional",
	tiles = {"mapgen_baobab_leaves.png",},
	special_tiles = {"mapgen_baobab_leaves_simple.png",},
	waving = 2,
	paramtype = "light",
	drop = {
		max_items = 1,
		items = {
			{items = {"default:baobab_sapling",},
				rarity = 20,},
			{items = {"mapgen:baobab_leaves",}},
		},
	},
	groups = {snappy = 3, flammable = 1, leaves = 1, leafdecay = 1},
	sounds = default.node_sound_leaves_defaults(),

	after_place_node = default.after_place_leaves,
})
default.register_leafdecay({
	trunks = {"mapgen:baobab_tree"},
	leaves = {"mapgen:baobab_leaves"},
	radius = 3,
})

function default.grow_new_baobab_tree(pos)
	local path = minetest.get_modpath("mapgen") ..
		"/schematics/baobab.mts"
	minetest.place_schematic({x = pos.x - 8, y = pos.y - 1, z = pos.z - 8},
		path, "random", nil, false)
	minetest.set_node(pos, {name="mapgen:baobab_tree"})
end
minetest.register_node("default:baobab_sapling", {
	description = "Baobab Sapling",
	drawtype = "plantlike",
	tiles = {"mapgen_baobab_sapling.png"},
	inventory_image = "mapgen_baobab_sapling.png",
	wield_image = "mapgen_baobab_sapling.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	on_timer = default.grow_sapling,
	selection_box = {
		type = "fixed",
		fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16}
	},
	groups = {snappy = 2, dig_immediate = 3, flammable = 2,
		attached_node = 1, sapling = 1},
	sounds = default.node_sound_leaves_defaults(),

	on_construct = function(pos)
		minetest.get_node_timer(pos):start(math.random(2400,4800))
	end,

	on_place = function(itemstack, placer, pointed_thing)
		itemstack = default.sapling_on_place(itemstack, placer, pointed_thing,
			"default:baobab_sapling",
			-- minp, maxp to be checked, relative to sapling pos
			-- minp_relative.y = 1 because sapling pos has been checked
			{x = -2, y = 1, z = -2},
			{x = 2, y = 15, z = 2},
			-- maximum interval of interior volume check
			4)

		return itemstack
	end,
})

default.register_fence("mapgen:fence_baobab", {
	description = "Baobab Fence",
	texture = "mapgen_baobab_fence.png",
	inventory_image = "default_fence_overlay.png^mapgen_baobab_fence.png^default_fence_overlay.png^[makealpha:255,126,126",
	wield_image = "default_fence_overlay.png^mapgen_baobab_fence.png^default_fence_overlay.png^[makealpha:255,126,126",
	material = "mapgen:baobab_wood",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
	sounds = default.node_sound_wood_defaults()
})

    minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"default:dirt_with_dry_grass"},
		sidelen = 16,
		noise_params = {
			offset = -0.05,
			scale = 0.001,
			spread = {x = 250, y = 250, z = 250},
			seed = 2,
			octaves = 3,
			persist = 0.66
		},
		biomes = {"savanna"},
		y_min = 1,
		y_max = 31000,
		schematic = minetest.get_modpath("mapgen") .. "/schematics/baobab.mts",
		flags = "place_center_x, place_center_z",
		rotation = "random",
	})

    minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"default:dirt_with_dry_grass"},
		sidelen = 16,
		noise_params = {
			offset = -0.001,
			scale = 0.001,
			spread = {x = 250, y = 250, z = 250},
			seed = 2,
			octaves = 3,
			persist = 0.66
		},
		biomes = {"savanna"},
		y_min = 1,
		y_max = 31000,
		schematic = minetest.get_modpath("mapgen") .. "/schematics/baobab1.mts",
		flags = "place_center_x, place_center_z",
		rotation = "random",
	})

    minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"default:dirt_with_dry_grass"},
		sidelen = 16,
		noise_params = {
			offset = -0.001,
			scale = 0.001,
			spread = {x = 250, y = 250, z = 250},
			seed = 2,
			octaves = 3,
			persist = 0.66
		},
		biomes = {"savanna"},
		y_min = 1,
		y_max = 31000,
		schematic = minetest.get_modpath("mapgen") .. "/schematics/baobab2.mts",
		flags = "place_center_x, place_center_z",
		rotation = "random",
	})
]]--
