---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cool_trees/chestnuttree
-- Code:    GPLv3
-- Media:   GPLv3
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("chestnuttree:bur", {
	description = S("Chestnut Bur"),
	drawtype = "plantlike",
	tiles = {"chestnuttree_bur.png"},
	inventory_image = "chestnuttree_bur.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	is_ground_content = false,
	selection_box = {
		type = "fixed",
		fixed = {-3 / 16, -7 / 16, -3 / 16, 3 / 16, 4 / 16, 3 / 16}
	},
	groups = {fleshy = 3, dig_immediate = 3, flammable = 2,
		leafdecay = 3, leafdecay_drop = 1},
	on_use = minetest.item_eat(2),
	sounds = default.node_sound_leaves_defaults(),

	after_place_node = function(pos, placer, itemstack)
		minetest.set_node(pos, {name = "chestnuttree:bur", param2 = 1})
	end,
})

minetest.register_node("chestnuttree:trunk", {
	description = S("Chestnut Tree Trunk"),
	tiles = {
		"chestnuttree_trunk_top.png",
		"chestnuttree_trunk_top.png",
		"chestnuttree_trunk.png"
	},
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir",
	on_place = minetest.rotate_node,
})
minetest.register_craft({
	type = "fuel",
	recipe = "chestnuttree:trunk",
	burntime = 30,
})

minetest.register_node("chestnuttree:wood", {
	description = S("Chestnut Tree Wood"),
	tiles = {"chestnuttree_wood.png"},
	is_ground_content = false,
	groups = {wood = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
})
minetest.register_craft({
	output = "chestnuttree:wood 4",
	recipe = {{"chestnuttree:trunk"}}
})
minetest.register_craft({
	type = "fuel",
	recipe = "chestnuttree:wood",
	burntime = 7,
})
if minetest.get_modpath("stairs") ~= nil then
	stairs.register_stair_and_slab(
		"chestnuttree_trunk",
		"chestnuttree:trunk",
		{choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
		{"chestnuttree_wood.png"},
		S("Chestnut Tree Stair"),
		S("Chestnut Tree Slab"),
		default.node_sound_wood_defaults()
	)
end
if minetest.get_modpath("moreblocks") then
	stairsplus:register_all("chestnuttree", "wood", "chestnuttree:wood", {
		description = "Chestnut Tree",
		tiles = {"chestnuttree_wood.png"},
		groups = {choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
		sounds = default.node_sound_wood_defaults(),
	})
end

minetest.register_node("chestnuttree:leaves", {
	description = S("Chestnut Tree Leaves"),
	drawtype = "allfaces_optional",
	tiles = {"chestnuttree_leaves.png"},
	paramtype = "light",
	walkable = true,
	waving = 1,
	groups = {snappy = 3, leafdecay = 3, leaves = 1, flammable = 2},
	drop = {
		max_items = 1,
		items = {
			{items = {"chestnuttree:sapling"}, rarity = 20},
			{items = {"chestnuttree:leaves"}}
		}
	},
	sounds = default.node_sound_leaves_defaults(),
	after_place_node = default.after_place_leaves,
})
default.register_leafdecay({
	trunks = {"chestnuttree:trunk"},
	leaves = {"chestnuttree:leaves"},
	radius = 3,
})

minetest.register_node("chestnuttree:sapling", {
	description = S("Chestnut Tree Sapling"),
	drawtype = "plantlike",
	tiles = {"chestnuttree_sapling.png"},
	inventory_image = "chestnuttree_sapling.png",
	wield_image = "chestnuttree_sapling.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	on_timer = grow_new_chestnuttree_tree,
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
			"chestnuttree:sapling",
			-- minp, maxp to be checked, relative to sapling pos
			-- minp_relative.y = 1 because sapling pos has been checked
			{x = -2, y = 1, z = -2},
			{x = 2, y = 6, z = 2},
			-- maximum interval of interior volume check
			4)

		return itemstack
	end,
})
local function grow_new_chestnuttree_tree(pos)
	if not default.can_grow(pos) then
		-- try a bit later again
		minetest.get_node_timer(pos):start(math.random(240, 600))
		return
	end
	minetest.remove_node(pos)
	minetest.place_schematic({x = pos.x-6, y = pos.y, z = pos.z-6}, modpath.."/schematics/chestnuttree.mts", "0", nil, false)
end
if minetest.global_exists("flowerpot") then
	flowerpot.register_node("chestnuttree:sapling")
end

if minetest.settings:get_bool("cool_fences", true) then
	local fence = {
		description = S("Chestnut Tree Wood Fence"),
		texture =  "chestnuttree_wood.png",
		material = "chestnuttree:wood",
		groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
		sounds = default.node_sound_wood_defaults(),
	}
	default.register_fence("chestnuttree:fence", table.copy(fence))
	fence.description = S("Chestnut Tree Fence Rail")
	default.register_fence_rail("chestnuttree:fence_rail", table.copy(fence))

	if minetest.get_modpath("doors") ~= nil then
		fence.description = S("Chestnut Tree Fence Gate")
		doors.register_fencegate("chestnuttree:gate", table.copy(fence))
	end
end

if mg_name ~= "v6" and mg_name ~= "singlenode" then

	local place_on
	local biomes
	local offset
	local scale

	if minetest.get_modpath("rainf") then
		place_on = "rainf:meadow"
		biomes = "rainf"
		offset = 0.0008
		scale = 0.00004
	else
		place_on = "default:dirt_with_grass"
		biomes = "grassland"
		offset = 0.00005
		scale = 0.00004
	end

	minetest.register_decoration({
		name = "chestnuttree:chestnut_tree",
		deco_type = "schematic",
		place_on = {place_on},
		sidelen = 16,
		noise_params = {
			offset = offset,
			scale = scale,
			spread = {x = 250, y = 250, z = 250},
			seed = 278,
			octaves = 3,
			persist = 0.66
		},
		biomes = {biomes},
		y_min = 1,
		y_max = 80,
		schematic = modpath.."/schematics/chestnuttree.mts",
		flags = "place_center_x, place_center_z,  force_placement",
		rotation = "random",
		place_offset_y = 1,
	})
end
]]--
