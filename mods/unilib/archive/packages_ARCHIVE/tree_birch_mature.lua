---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cool_trees/birch
-- Code:    GPLv3
-- Media:   GPLv3
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("birch:trunk", {
	description = S("Birch Trunk"),
	tiles = {
		"birch_trunk_top.png",
		"birch_trunk_top.png",
		"birch_trunk.png"
	},
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir",
	on_place = minetest.rotate_node,
	is_ground_content = false,
})
minetest.register_craft({
	type = "fuel",
	recipe = "birch:trunk",
	burntime = 30,
})

minetest.register_node("birch:wood", {
	description = S("Birch Wood"),
	tiles = {"birch_wood.png"},
	is_ground_content = false,
	groups = {wood = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
})
minetest.register_craft({
	output = "birch:wood 4",
	recipe = {{"birch:trunk"}}
})
minetest.register_craft({
	type = "fuel",
	recipe = "birch:wood",
	burntime = 7,
})
if minetest.get_modpath("stairs") ~= nil then
	stairs.register_stair_and_slab(
		"birch_trunk",
		"birch:trunk",
		{choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
		{"birch_wood.png"},
		S("Birch Tree Stair"),
		S("Birch Tree Slab"),
		default.node_sound_wood_defaults()
	)
end
if minetest.get_modpath("moreblocks") then
	stairsplus:register_all("birch", "wood", "birch:wood", {
		description = "Birch",
		tiles = {"birch_wood.png"},
		groups = {choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
		sounds = default.node_sound_wood_defaults(),
	})
end

minetest.register_node("birch:leaves", {
	description = S("Birch Leaves"),
	drawtype = "allfaces_optional",
	tiles = {"birch_leaves.png"},
	paramtype = "light",
	walkable = true,
	waving = 1,
	groups = {snappy = 3, leafdecay = 3, leaves = 1, flammable = 2},
	drop = {
		max_items = 1,
		items = {
			{items = {"birch:sapling"}, rarity = 20},
			{items = {"birch:leaves"}}
		}
	},
	sounds = default.node_sound_leaves_defaults(),
	after_place_node = default.after_place_leaves,
})
default.register_leafdecay({
	trunks = {"birch:trunk"},
	leaves = {"birch:leaves"},
	radius = 3,
})

minetest.register_node("birch:sapling", {
	description = S("Birch Sapling"),
	drawtype = "plantlike",
	tiles = {"birch_sapling.png"},
	inventory_image = "birch_sapling.png",
	wield_image = "birch_sapling.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	on_timer = grow_new_birch_tree,
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
			"birch:sapling",
			-- minp, maxp to be checked, relative to sapling pos
			-- minp_relative.y = 1 because sapling pos has been checked
			{x = -2, y = 1, z = -2},
			{x = 2, y = 6, z = 2},
			-- maximum interval of interior volume check
			4)

		return itemstack
	end,
})
local function grow_new_birch_tree(pos)
	if not default.can_grow(pos) then
		-- try a bit later again
		minetest.get_node_timer(pos):start(math.random(240, 600))
		return
	end
	minetest.remove_node(pos)
	minetest.place_schematic({x = pos.x - 2, y = pos.y - 1, z = pos.z - 2}, birch.birchtree, "0", nil, false)
end
if minetest.global_exists("flowerpot") then
	flowerpot.register_node("birch:sapling")
end

if minetest.settings:get_bool("cool_fences", true) then
	local fence = {
		description = S("Birch Fence"),
		texture =  "birch_wood.png",
		material = "birch:wood",
		groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
		sounds = default.node_sound_wood_defaults(),
	}
	default.register_fence("birch:fence", table.copy(fence))
	fence.description = S("Birch Fence Rail")
	default.register_fence_rail("birch:fence_rail", table.copy(fence))

	if minetest.get_modpath("doors") ~= nil then
		fence.description = S("Birch Fence Gate")
		doors.register_fencegate("birch:gate", table.copy(fence))
	end
end

local place_on
local biomes
local offset
local scale

if minetest.get_modpath("rainf") then
	place_on = "rainf:meadow"
	biomes = "rainf"
	offset = 0.01
	scale = 0.001
else
	place_on = "default:dirt_with_grass"
	biomes = "grassland"
	offset = 0.008
	scale = 0.001
end

minetest.register_decoration({
	name = "birch:birch_tree",
	deco_type = "schematic",
	place_on = {place_on},
	sidelen = 16,
	noise_params = {
		offset = offset,
		scale = scale,
		spread = {x = 255, y = 255, z = 255},
		seed = 32,
		octaves = 3,
		persist = 0.67
	},
	biomes = {biomes},
	y_min = 1,
	y_max = 80,
	schematic = birch.birchtree,
	flags = "place_center_x, place_center_z",
	place_offset_y = 1,
})
]]--
