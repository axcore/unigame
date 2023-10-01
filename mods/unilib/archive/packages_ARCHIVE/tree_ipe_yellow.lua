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
minetest.register_node("mapgen:yellow_ipe_tree", {
	description = "Yellow Ipe Tree",
	tiles = {
		"mapgen_yellow_ipe_tree_top.png",
		"mapgen_yellow_ipe_tree_top.png",
		"mapgen_yellow_ipe_tree.png",
	},
	groups = {choppy = 2, tree = 1, flammable = 1, oddly_breakable_by_hand=1},
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir",
	on_place = minetest.rotate_node
})

minetest.register_node("mapgen:yellow_ipe_wood", {
	description = "Yellow Ipe Planks",
	tiles = {
		"mapgen_yellow_ipe_wood.png",
	},
	groups = {choppy = 1, flammable = 1, oddly_breakable_by_hand=1, wood=1},
	sounds = default.node_sound_wood_defaults()
})
minetest.register_craft( {
	output = "mapgen:yellow_ipe_wood 4",
	recipe = {
		{ "mapgen:yellow_ipe_tree",},
	}
})

minetest.register_node("mapgen:yellow_ipe_leaves", {
	description = "Yellow Ipe Leaves",
	drawtype = "allfaces_optional",
	tiles = {"mapgen_yellow_ipe_leaves.png",},
	special_tiles = {"mapgen_yellow_ipe_leaves_simple.png",},
	waving = 2,
	paramtype = "light",
	drop = {
		max_items = 1,
		items = {
			{items = {"default:ipe_sapling",},
				rarity = 20,},
			{items = {"mapgen:yellow_ipe_leaves",}},
		},
	},
	groups = {snappy = 3, flammable = 1, leaves = 1, leafdecay = 1},
	sounds = default.node_sound_leaves_defaults(),
	after_place_node = default.after_place_leaves,
})
default.register_leafdecay({
	trunks = {"mapgen:yellow_ipe_tree"},
	leaves = {"mapgen:yellow_ipe_leaves"},
	radius = 3,
})

function default.grow_new_ipe_tree(pos)
	local path = minetest.get_modpath("mapgen") ..
		"/schematics/ipe.mts"
	minetest.place_schematic({x = pos.x, y = pos.y - 1, z = pos.z},
		path, "random", nil, false, "place_center_x, place_center_z")
	minetest.set_node(pos, {name="mapgen:yellow_ipe_tree"})
end
minetest.register_node("default:ipe_sapling", {
	description = "Yellow Ipe Sapling",
	drawtype = "plantlike",
	tiles = {"mapgen_yellow_ipe_sapling.png"},
	inventory_image = "mapgen_yellow_ipe_sapling.png",
	wield_image = "mapgen_yellow_ipe_sapling.png",
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
			"default:ipe_sapling",
			-- minp, maxp to be checked, relative to sapling pos
			-- minp_relative.y = 1 because sapling pos has been checked
			{x = -2, y = 1, z = -2},
			{x = 2, y = 15, z = 2},
			-- maximum interval of interior volume check
			4)

		return itemstack
	end,
})

default.register_fence("mapgen:fence_yellow_ipe", {
	description = "Yellow Ipe Fence",
	texture = "mapgen_yellow_ipe_fence.png",
	inventory_image = "default_fence_overlay.png^mapgen_yellow_ipe_fence.png^default_fence_overlay.png^[makealpha:255,126,126",
	wield_image = "default_fence_overlay.png^mapgen_yellow_ipe_fence.png^default_fence_overlay.png^[makealpha:255,126,126",
	material = "mapgen:yellow_ipe_wood",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
	sounds = default.node_sound_wood_defaults()
})

	minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"default:dirt_with_grass"},
		sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.002,
			spread = {x = 250, y = 250, z = 250},
			seed = 2,
			octaves = 3,
			persist = 0.66
		},
		biomes = {"deciduous_forest2"},
		y_min = 1,
		y_max = 31000,
		schematic = minetest.get_modpath("mapgen") .. "/schematics/ipe.mts",
		flags = "place_center_x, place_center_z",
		rotation = "random",
	})
]]--
