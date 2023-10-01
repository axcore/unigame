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
minetest.register_node("mapgen:palm_tree", {
	description = "Palm Tree",
	tiles = {
		"mapgen_palmtree_top.png",
		"mapgen_palmtree_top.png",
		"mapgen_palmtree_side.png",
	},
	groups = {choppy = 2, tree = 1, flammable = 1, oddly_breakable_by_hand=1},
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir",
	on_place = minetest.rotate_node
})

minetest.register_node("mapgen:palm_wood", {
	description = "Palm Wood Planks",
	tiles = {
		"mapgen_palm_wood.png",
	},
	groups = {choppy = 1, flammable = 1, oddly_breakable_by_hand=1, wood=1},
	sounds = default.node_sound_wood_defaults()
})
minetest.register_craft( {
	output = "mapgen:palm_wood 4",
	recipe = {
		{ "mapgen:palm_tree",},
	}
})

minetest.register_node("mapgen:palm_leaves", {
	description = "Palm Leaves",
	drawtype = "allfaces_optional",
	tiles = {"mapgen_palmleaves.png",},
	special_tiles = {"mapgen_palmleaves_simple.png",},
	waving = 2,
	paramtype = "light",
	drop = {
		max_items = 1,
		items = {
			{items = {"default:palmtree_sapling",},
				rarity = 20,},
			{items = {"mapgen:palm_leaves",}},
		},
	},
	groups = {snappy = 3, flammable = 1, leaves = 1, leafdecay = 1},
	sounds = default.node_sound_leaves_defaults(),
	after_place_node = default.after_place_leaves,
})
default.register_leafdecay({
	trunks = {"mapgen:palm_tree"},
	leaves = {"mapgen:palm_leaves"},
	radius = 3,
})

function default.grow_new_palm_tree(pos)
	local path = minetest.get_modpath("mapgen") ..
		"/schematics/palmtree.mts"
	minetest.place_schematic({x = pos.x - 3, y = pos.y - 1, z = pos.z - 3},
		path, "random", nil, false)
	minetest.set_node(pos, {name="mapgen:palm_tree"})
end
minetest.register_node("default:palmtree_sapling", {
	description = "Palm Tree Sapling",
	drawtype = "plantlike",
	tiles = {"mapgen_palmtree_sapling.png"},
	inventory_image = "mapgen_palmtree_sapling.png",
	wield_image = "mapgen_palmtree_sapling.png",
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
			"default:palmtree_sapling",
			-- minp, maxp to be checked, relative to sapling pos
			-- minp_relative.y = 1 because sapling pos has been checked
			{x = -2, y = 1, z = -2},
			{x = 2, y = 15, z = 2},
			-- maximum interval of interior volume check
			4)

		return itemstack
	end,
})

default.register_fence("mapgen:fence_palm_wood", {
	description = "palm fence",
	texture = "mapgen_palm_fence.png",
	inventory_image = "default_fence_overlay.png^mapgen_palm_fence.png^default_fence_overlay.png^[makealpha:255,126,126",
	wield_image = "default_fence_overlay.png^mapgen_palm_fence.png^default_fence_overlay.png^[makealpha:255,126,126",
	material = "mapgen:baobab_wood",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
	sounds = default.node_sound_wood_defaults()
})

minetest.register_decoration({
	deco_type = "schematic",
	place_on = {"default:sand",},
	sidelen = 16,
	noise_params = {
		offset = 0.002,
		scale = 0.001,
		spread = {x = 250, y = 250, z = 250},
		seed = 2,
		octaves = 3,
		persist = 0.66
	},
	y_min = 1,
	y_max = 31000,
	schematic = minetest.get_modpath("mapgen").."/schematics/palmtree.mts",
	replacements = {["mapgen:palm_leaves_coconut"] = "mapgen:palm_leaves"},
	flags = "place_center_x, place_center_z",
})

minetest.register_decoration({
	deco_type = "schematic",
	place_on = {"mapgen:dirt_with_junglegrass", "default:dirt_with_grass"},
	sidelen = 16,
	noise_params = {
		offset = 0.002,
		scale = 0.001,
		spread = {x = 250, y = 250, z = 250},
		seed = 2,
		octaves = 3,
		persist = 0.66
	},
	biomes = {"rainforest"},
	y_min = 1,
	y_max = 31000,
	schematic = minetest.get_modpath("mapgen").."/schematics/palmtree.mts",
	flags = "place_center_x, place_center_z",
})
]]--
