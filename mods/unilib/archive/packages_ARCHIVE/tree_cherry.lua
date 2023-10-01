---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cool_trees/cherrytree
-- Code:    GPLv3
-- Media:   GPLv3
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("cherrytree:trunk", {
	description = S("Cherrytree Trunk"),
	tiles = {
		"cherrytree_trunk_top.png",
		"cherrytree_trunk_top.png",
		"cherrytree_trunk.png"
	},
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir",
	is_ground_content = false,
	on_place = minetest.rotate_node,
})
minetest.register_craft({
	type = "fuel",
	recipe = "cherrytree:trunk",
	burntime = 30,
})

minetest.register_node("cherrytree:wood", {
	description = S("Cherrytree Wood"),
	tiles = {"cherrytree_wood.png"},
	paramtype2 = "facedir",
	place_param2 = 0,
	is_ground_content = false,
	groups = {wood = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
})
minetest.register_craft({
	output = "cherrytree:wood 4",
	recipe = {{"cherrytree:trunk"}}
})
minetest.register_craft({
	type = "fuel",
	recipe = "cherrytree:wood",
	burntime = 7,
})
if minetest.get_modpath("stairs") ~= nil then
	stairs.register_stair_and_slab(
		"cherrytree_trunk",
		"cherrytree:trunk",
		{choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
		{"cherrytree_wood.png"},
		S("Cherry Tree Stair"),
		S("Cherry Tree Slab"),
		default.node_sound_wood_defaults()
	)
end
if minetest.get_modpath("moreblocks") then
	stairsplus:register_all("cherrytree", "wood", "cherrytree:wood", {
		description = "Cherry Tree",
		tiles = {"cherrytree_wood.png"},
		groups = {choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
		sounds = default.node_sound_wood_defaults(),
	})
end

minetest.register_node("cherrytree:leaves", {
	description = S("Cherrytree Leaves"),
	drawtype = "allfaces_optional",
	tiles = {"cherrytree_leaves.png"},
	paramtype = "light",
	walkable = true,
	waving = 1,
	groups = {snappy = 3, leafdecay = 3, leaves = 1, flammable = 2},
	drop = {
		max_items = 1,
		items = {
			{items = {"cherrytree:sapling"}, rarity = 20},
			{items = {"cherrytree:leaves"}}
		}
	},
	sounds = default.node_sound_leaves_defaults(),
	after_place_node = default.after_place_leaves,
})
default.register_leafdecay({
	trunks = {"cherrytree:trunk"},
	leaves = {"cherrytree:leaves"},
	radius = 3,
})

minetest.register_node("cherrytree:blossom_leaves", {
	description = S("Cherrytree Blossom Leaves"),
	drawtype = "allfaces_optional",
	tiles = {"cherrytree_blossom_leaves.png"},
	paramtype = "light",
	walkable = true,
	waving = 1,
	groups = {snappy = 3, leafdecay = 3, leaves = 1, flammable = 2},
	drop = {
		max_items = 1,
		items = {
			{items = {"cherrytree:sapling"}, rarity = 12},
			{items = {"cherrytree:blossom_leaves"}}
		}
	},
	sounds = default.node_sound_leaves_defaults(),
	after_place_node = default.after_place_leaves,

	on_timer = function(pos)
		pos.y = pos.y - 1
		local node = minetest.get_node_or_nil(pos)
		if node and node.name == "air" then
			minetest.set_node(pos, {name = "cherrytree:cherries"})
			return false
		else
			return true
		end
    end
})
default.register_leafdecay({
	trunks = {"cherrytree:trunk"},
	leaves = {"cherrytree:blossom_leaves"},
	radius = 3,
})

minetest.register_node("cherrytree:sapling", {
	description = S("Cherrytree Tree Sapling"),
	drawtype = "plantlike",
	tiles = {"cherrytree_sapling.png"},
	inventory_image = "cherrytree_sapling.png",
	wield_image = "cherrytree_sapling.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	on_timer = grow_new_cherrytree_tree,
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
			"cherrytree:sapling",
			-- minp, maxp to be checked, relative to sapling pos
			-- minp_relative.y = 1 because sapling pos has been checked
			{x = -2, y = 1, z = -2},
			{x = 2, y = 6, z = 2},
			-- maximum interval of interior volume check
			4)

		return itemstack
	end,
})
if minetest.global_exists("flowerpot") then
	flowerpot.register_node("cherrytree:sapling")
end

if minetest.settings:get_bool("cool_fences", true) then
	local fence = {
		description = S("Cherry Tree Wood Fence"),
		texture =  "cherrytree_wood.png",
		material = "cherrytree:wood",
		groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
		sounds = default.node_sound_wood_defaults(),
	}
	default.register_fence("cherrytree:fence", table.copy(fence))
	fence.description = S("Cherry Tree Fence Rail")
	default.register_fence_rail("cherrytree:fence_rail", table.copy(fence))

	if minetest.get_modpath("doors") ~= nil then
		fence.description = S("Cherry Tree Fence Gate")
		doors.register_fencegate("cherrytree:gate", table.copy(fence))
	end
end

if mg_name ~= "v6" and mg_name ~= "singlenode" then
	minetest.register_decoration({
		name = "cherrytree:cherry_tree",
		deco_type = "schematic",
		place_on = {"default:dirt_with_grass"},
		sidelen = 16,
		noise_params = {
			offset = 0.0005,
			scale = 0.00005,
			spread = {x = 250, y = 250, z = 250},
			seed = 1242,
			octaves = 3,
			persist = 0.66
		},
		biomes = {"deciduous_forest"},
		y_min = 1,
		y_max = 32,
		schematic = modpath.."/schematics/cherrytree.mts",
		flags = "place_center_x, place_center_z, force_placement",
		rotation = "random",
	})
end
]]--
