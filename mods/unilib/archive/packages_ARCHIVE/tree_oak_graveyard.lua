---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    grave
-- Code:    GPL-3.0
-- Media:   GPL-3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("grave:grave_oak_tree", {
	description = "Grave Oak Tree",
	tiles = {"grave_grave_oak_tree_top.png", "grave_grave_oak_tree_top.png", "grave_grave_oak_tree.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults(),
	on_place = minetest.rotate_node
})

minetest.register_node("grave:grave_oak_wood", {
	description = "Grave Oak Wood Planks",
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"grave_grave_oak_wood.png"},
	is_ground_content = false,
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, wood = 1},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("grave:grave_oak_leaves", {
	description = "Grave Oak Leaves",
	drawtype = "allfaces_optional",
	waving = 1,
	tiles = {"grave_grave_oak_leaves.png"},
	paramtype = "light",
	is_ground_content = false,
	groups = {snappy = 3, leafdecay = 3, flammable = 2, leaves = 1},
	drop = {
		max_items = 1,
		items = {
			{
				-- player will get sapling with 1/20 chance
				items = {"grave:grave_oak_sapling"},
				rarity = 20,
			},
			{
				-- player will get leaves only if he get no saplings,
				-- this is because max_items is 1
				items = {"grave:grave_oak_leaves"},
			}
		}
	},
	sounds = default.node_sound_leaves_defaults(),

	after_place_node = after_place_leaves,
})

minetest.register_node("grave:grave_oak_sapling", {
	description = "Grave Oak Tree Sapling",
	drawtype = "plantlike",
	tiles = {"grave_grave_oak_sapling.png"},
	inventory_image = "grave_grave_oak_sapling.png",
	wield_image = "grave_grave_oak_sapling.png",
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
			"grave:grave_oak_sapling",
			{x = -3, y = 1, z = -3},
			{x = 3, y = 6, z = 3},
			4)
		return itemstack
	end,
})

default.register_fence("grave:fence_grave_oak_wood", {
	description = "Grave Oak Wood Fence",
	texture = "grave_fence_grave_oak_wood.png",
	inventory_image = "default_fence_overlay.png^grave_grave_oak_wood.png^" ..
				"default_fence_overlay.png^[makealpha:255,126,126",
	wield_image = "default_fence_overlay.png^grave_grave_oak_wood.png^" ..
				"default_fence_overlay.png^[makealpha:255,126,126",
	material = "grave:grave_oak_wood",
	groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	sounds = default.node_sound_wood_defaults()
})

default.register_fence_rail("grave:fence_rail_grave_oak_wood", {
	description = "Grave Oak Wood Fence Rail",
	texture = "grave_fence_rail_grave_oak_wood.png",
	inventory_image = "default_fence_rail_overlay.png^grave_grave_oak_wood.png^" ..
				"default_fence_rail_overlay.png^[makealpha:255,126,126",
	wield_image = "default_fence_rail_overlay.png^grave_grave_oak_wood.png^" ..
				"default_fence_rail_overlay.png^[makealpha:255,126,126",
	material = "grave:grave_oak_wood",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
	sounds = default.node_sound_wood_defaults()
})

minetest.register_decoration({
	name = "grave:grave_oak_tree",
	deco_type = "schematic",
	place_on = {"grave:grave_dirt_with_grave_grass"},
	sidelen = 80,
	noise_params = {
		offset = 0.010,
		scale = -0.048,
		spread = {x = 50, y = 50, z = 50},
		seed = 2,
		octaves = 3,
		persist = 0.66
	},
	y_min = 1,
	y_max = 31000,
	schematic = minetest.get_modpath("grave") .. "/schems/grave_grave_oak.mts",
	flags = "place_center_x, place_center_z",
	rotation = "random"
})
]]--
