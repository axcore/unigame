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
minetest.register_node("mapgen:willow_tree", {
	description = "Willow Tree",
	tiles = {
		"mapgen_willow_tree_top.png",
		"mapgen_willow_tree_top.png",
		"mapgen_willow_tree.png",
	},
	groups = {choppy = 2, tree = 1, flammable = 1, oddly_breakable_by_hand=1},
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir",
	on_place = minetest.rotate_node
})

minetest.register_node("mapgen:willow_wood", {
	description = "Willow Wood Planks",
	tiles = {
		"mapgen_willow_wood.png",
	},
	groups = {choppy = 1, flammable = 1, oddly_breakable_by_hand=1, wood=1},
	sounds = default.node_sound_wood_defaults()
})
minetest.register_craft( {
	output = "mapgen:willow_wood 4",
	recipe = {
		{ "mapgen:willow_tree",},
	}
})

minetest.register_node("mapgen:willow_leaves", {
	description = "Willow Leaves",
	drawtype = "allfaces_optional",
	tiles = {"mapgen_willow_leaves.png",},
	special_tiles = {"mapgen_willow_leaves_simple.png",},
	waving = 2,
	paramtype = "light",
	drop = {
		max_items = 1,
		items = {
			{items = {"default:willow_sapling",},
				rarity = 20,},
			{items = {"mapgen:willow_leaves",}},
		},
	},
	groups = {snappy = 3, flammable = 1, leaves = 1, leafdecay = 1},
	sounds = default.node_sound_leaves_defaults(),
	after_place_node = default.after_place_leaves,
})
default.register_leafdecay({
	trunks = {"mapgen:willow_tree"},
	leaves = {"mapgen:willow_leaves"},
	radius = 3,
})

function default.grow_new_willow_tree(pos)
	local path = minetest.get_modpath("mapgen") ..
		"/schematics/willow.mts"
	minetest.place_schematic({x = pos.x - 2, y = pos.y - 1, z = pos.z - 2},
		path, "random", nil, false)
	minetest.set_node(pos, {name="mapgen:willow_tree"})
end
minetest.register_node("default:willow_sapling", {
	description = "Willow Tree Sapling",
	drawtype = "plantlike",
	tiles = {"mapgen_willow_sapling.png"},
	inventory_image = "mapgen_willow_sapling.png",
	wield_image = "mapgen_willow_sapling.png",
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
			"default:willow_sapling",
			-- minp, maxp to be checked, relative to sapling pos
			-- minp_relative.y = 1 because sapling pos has been checked
			{x = -2, y = 1, z = -2},
			{x = 2, y = 15, z = 2},
			-- maximum interval of interior volume check
			4)

		return itemstack
	end,
})

	minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"mapgen:dirt_with_swampgrass"},
		sidelen = 16,
		noise_params = {
			offset = 0.0,
			scale = -0.015,
			spread = {x = 250, y = 250, z = 250},
			seed = 2,
			octaves = 3,
			persist = 0.66
		},
		biomes = {"swamp"},
		y_min = 1,
		y_max = 31000,
		schematic = minetest.get_modpath("mapgen") .. "/schematics/willow.mts",
		flags = "place_center_x, place_center_z",
	})

	minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"mapgen:dirt_with_swampgrass"},
		sidelen = 16,
		noise_params = {
			offset = 0.01,
			scale = 0.001,
			spread = {x = 250, y = 250, z = 250},
			seed = 2,
			octaves = 3,
			persist = 0.66
		},
		biomes = {"swamp"},
		y_min = 1,
		y_max = 31000,
		schematic = minetest.get_modpath("mapgen") .. "/schematics/willow2.mts",
		flags = "place_center_x, place_center_z",
	})
]]--
