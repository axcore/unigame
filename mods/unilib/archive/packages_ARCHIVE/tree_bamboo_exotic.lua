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
minetest.register_node("mapgen:bamboo", {
	description = "Bamboo",
	tiles = {
	"mapgen_bamboo_top.png",
	"mapgen_bamboo_top.png",
	"mapgen_bamboo.png"
	},
	use_texture_alpha = "clip",
	is_ground_content = false,
	sunlight_propagates = false,
	groups = {choppy=1, flammable=1, oddly_breakable_by_hand=1, tree=1},
	sounds = default.node_sound_wood_defaults(),
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.1875, -0.5, -0.1875, 0.1875, 0.5, 0.1875}, -- NodeBox1
			{-0.5, -0.5, 0, 0.5, 0.5, 0}, -- NodeBox2
			{0.00470524, -0.5, -0.5, 0.00470524, 0.5, 0.5}, -- NodeBox3
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.1875, -0.5, -0.1875, 0.1875, 0.5, 0.1875},
		}
	},
	collision_box = {
		type = "fixed",
		fixed = {
			{-0.1875, -0.5, -0.1875, 0.1875, 0.5, 0.1875},
		}
	},
	walkable = true,
})

minetest.register_node("mapgen:bamboo_with_leaves", {
	description = "Bamboo With Leaves",
	tiles = {
	"mapgen_bamboo_top.png",
	"mapgen_bamboo_top.png",
	"mapgen_bamboo_leaves.png^mapgen_bamboo.png"
	},
	use_texture_alpha = "clip",
	is_ground_content = false,
	sunlight_propagates = false,
	groups = {choppy=1, flammable=1, oddly_breakable_by_hand=1, tree=1, leaves=1},
	sounds = default.node_sound_wood_defaults(),
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.1875, -0.5, -0.1875, 0.1875, 0.5, 0.1875}, -- NodeBox1
			{-0.5, -0.5, 0, 0.5, 0.5, 0}, -- NodeBox2
			{0.00470524, -0.5, -0.5, 0.00470524, 0.5, 0.5}, -- NodeBox3
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.1875, -0.5, -0.1875, 0.1875, 0.5, 0.1875},
		}
	},
	collision_box = {
		type = "fixed",
		fixed = {
			{-0.1875, -0.5, -0.1875, 0.1875, 0.5, 0.1875},
		}
	},
	drop = "mapgen:bamboo"
})

minetest.register_node("mapgen:bamboo_wood", {
	description = "Bamboo Wood Planks",
	tiles = {"mapgen_bamboo_planks.png"},
	groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3, wood = 1},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_craft( {
	output = "mapgen:bamboo_wood 4",
	recipe = {
		{ "mapgen:bamboo",},
	}
})
minetest.register_craft( {
	output = "mapgen:bamboo_wood 4",
	recipe = {
		{ "mapgen:bamboo_with_leaves",},
	}
})

minetest.register_node("mapgen:bamboo_leaves", {
	description = "Bamboo Leaves",
	drawtype = "allfaces_optional",
	tiles = {"mapgen_bamboo_leaves.png"},
	use_texture_alpha = "clip",
	waving = 1,
	paramtype = "light",
	is_ground_content = false,
	sunlight_propagates = false,
	groups = {snappy=3, flammable=1, leafdecay=4, leaves=1},
	sounds = default.node_sound_leaves_defaults(),
	drop = {
		max_items = 1,
		items = {
			{items = {"default:bamboo_sapling",},
				rarity = 20,},
			{items = {"mapgen:bamboo_leaves",}},
		},
	},
	after_place_node = default.after_place_leaves,
})
default.register_leafdecay({
	trunks = {"mapgen:bamboo", "mapgen:bamboo_with_leaves"},
	leaves = {"mapgen:bamboo_leaves"},
	radius = 1,
})

function default.grow_new_bamboo_tree(pos)
	local path = minetest.get_modpath("mapgen") ..
		"/schematics/bamboo1.mts"
	minetest.place_schematic({x = pos.x - 2, y = pos.y - 1, z = pos.z - 2},
		path, "random", nil, false)
	minetest.set_node(pos, {name="mapgen:bamboo"})
end
minetest.register_node("default:bamboo_sapling", {
	description = "Bamboo Sapling",
	drawtype = "plantlike",
	tiles = {"mapgen_bamboo_sapling.png"},
	inventory_image = "mapgen_bamboo_sapling.png",
	wield_image = "mapgen_bamboo_sapling.png",
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
			"default:bamboo_sapling",
			-- minp, maxp to be checked, relative to sapling pos
			-- minp_relative.y = 1 because sapling pos has been checked
			{x = -2, y = 1, z = -2},
			{x = 2, y = 15, z = 2},
			-- maximum interval of interior volume check
			4)

		return itemstack
	end,
})

minetest.register_node("decoblocks:bamboo_fence", {
	description = "Bamboo Fence",
	tiles = {
		"decoblocks_bamboo_fence_top.png",
		"decoblocks_bamboo_fence_top.png",
		"decoblocks_bamboo_fence.png",
	},
	use_texture_alpha = "opaque",
	inventory_image = "default_fence_overlay.png^decoblocks_bamboo.png^default_fence_overlay.png^[makealpha:255,126,126",
	wield_image = "default_fence_overlay.png^decoblocks_bamboo.png^default_fence_overlay.png^[makealpha:255,126,126",
	drawtype = "nodebox",
	paramtype = "light",
	connects_to = {"group:fence", "group:wood", "group:choppy", "group:stone"},
	node_box = {
		type = "connected",
		fixed = {
			{-0.125, -0.5, -0.125, 0.125, 0.5, 0.125}, -- NodeBox1
		},
		connect_back = {
			{-0.0625, 0.25, -0.0625, 0.0625, 0.375, 0.5}, -- NodeBox2
			{-0.0625, -0.0625, -0.0625, 0.0625, 0.0625, 0.5}, -- NodeBox3
			{-0.0625, -0.375, -0.0625, 0.0625, -0.25, 0.5}, -- NodeBox4
		},
		connect_front = {
			{-0.0625, 0.25, -0.5, 0.0625, 0.375, 0.0625}, -- NodeBox2
			{-0.0625, -0.0625, -0.5, 0.0625, 0.0625, 0.0625}, -- NodeBox3
			{-0.0625, -0.375, -0.5, 0.0625, -0.25, 0.0625}, -- NodeBox4
		},
		connect_left = {
			{-0.5, 0.25, -0.0625, 0.0625, 0.375, 0.0625}, -- NodeBox2
			{-0.5, -0.0625, -0.0625, 0.0625, 0.0625, 0.0625}, -- NodeBox3
			{-0.5, -0.375, -0.0625, 0.0625, -0.25, 0.0625}, -- NodeBox4
		},
		connect_right = {
			{0, 0.25, -0.0625, 0.5, 0.375, 0.0625}, -- NodeBox2
			{0, -0.0625, -0.0625, 0.5, 0.0625, 0.0625}, -- NodeBox3
			{0, -0.375, -0.0625, 0.5, -0.25, 0.0625}, -- NodeBox4
		}
	},
	groups = {choppy=1, oddly_breakable_by_hand=1, fence=1},
	sounds = default.node_sound_wood_defaults()
})
minetest.register_craft({
	output = 'decoblocks:bamboo_fence',
	recipe = {
		{'mapgen:bamboo', 'mapgen:bamboo', 'mapgen:bamboo'},
		{'mapgen:bamboo', 'mapgen:bamboo', 'mapgen:bamboo'},
	}
})

doors.register_fencegate("doors:gate_bamboo", {
	description = "Bamboo Fence Gate",
	texture = "decoblocks_bamboo.png",
	material = "decoblocks:bamboo_block",
	groups = {door=1, choppy = 3, oddly_breakable_by_hand = 2, flammable = 3}
})

    minetest.register_node("decoblocks:bamboo_block", {
        description = "Bamboo Block",
        tiles = {
            "decoblocks_bamboo_top.png",
            "decoblocks_bamboo_top.png",
            "decoblocks_bamboo.png",
        },
        paramtype2 = "facedir",
        groups = {choppy = 1, oddly_breakable_by_hand = 2, wood=1},
        sounds = default.node_sound_wood_defaults(),
        on_place = minetest.rotate_node
    })
minetest.register_craft( {
	output = "decoblocks:bamboo_block 4",
	recipe = {
		{ "mapgen:bamboo", "mapgen:bamboo",},
		{ "mapgen:bamboo", "mapgen:bamboo",}
	}
})

	minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"default:dirt_with_grass"},
		sidelen = 16,
		noise_params = {
			offset = 0.016,
			scale = 0.022,
			spread = {x = 250, y = 250, z = 250},
			seed = 2,
			octaves = 3,
			persist = 0.66
		},
		biomes = {"bamboo_forest",},
		y_min = 1,
		y_max = 31000,
		schematic = minetest.get_modpath("mapgen") .. "/schematics/bamboo1.mts",
		flags = "place_center_x, place_center_z",
	})

    minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"default:dirt_with_grass"},
		sidelen = 16,
		noise_params = {
			offset = 0.016,
			scale = 0.022,
			spread = {x = 250, y = 250, z = 250},
			seed = 2,
			octaves = 3,
			persist = 0.66
		},
		biomes = {"bamboo_forest",},
		y_min = 1,
		y_max = 31000,
		schematic = minetest.get_modpath("mapgen") .. "/schematics/bamboo2.mts",
		flags = "place_center_x, place_center_z",
	})
]]--
