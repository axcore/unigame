---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cool_trees/oak
-- Code:    GPLv3
-- Media:   GPLv3
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("oak:trunk", {
	description = S("Oak Trunk"),
	tiles = {
		"oak_trunk_top.png",
		"oak_trunk_top.png",
		"oak_trunk.png"
	},
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir",
	on_place = minetest.rotate_node,
})
minetest.register_craft({
	type = "fuel",
	recipe = "oak:trunk",
	burntime = 30,
})

minetest.register_node("oak:wood", {
	description = S("Oak Wood"),
	tiles = {"oak_wood.png"},
	is_ground_content = false,
	groups = {wood = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
})
minetest.register_craft({
	output = "oak:wood 4",
	recipe = {{"oak:trunk"}}
})
minetest.register_craft({
	type = "fuel",
	recipe = "oak:wood",
	burntime = 7,
})
if minetest.get_modpath("stairs") ~= nil then
	stairs.register_stair_and_slab(
		"oak_trunk",
		"oak:trunk",
		{choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
		{"oak_wood.png"},
		S("Oak Stair"),
		S("Oak Slab"),
		default.node_sound_wood_defaults()
	)
end
if minetest.get_modpath("moreblocks") then
	stairsplus:register_all("oak", "wood", "oak:wood", {
		description = "Oak",
		tiles = {"oak_wood.png"},
		groups = {choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
		sounds = default.node_sound_wood_defaults(),
	})
end

minetest.register_node("oak:leaves", {
	description = S("Oak Leaves"),
	drawtype = "allfaces_optional",
	tiles = {"oak_leaves.png"},
	paramtype = "light",
	walkable = true,
	waving = 1,
	groups = {snappy = 3, leafdecay = 3, leaves = 1, flammable = 2},
	drop = {
		max_items = 1,
		items = {
			{items = {"oak:sapling"}, rarity = 20},
			{items = {"oak:leaves"}}
		}
	},
	sounds = default.node_sound_leaves_defaults(),
	after_place_node = default.after_place_leaves,
})
default.register_leafdecay({
	trunks = {"oak:trunk"},
	leaves = {"oak:leaves"},
	radius = 3,
})

minetest.register_node("oak:sapling", {
	description = S("Oak Sapling"),
	drawtype = "plantlike",
	tiles = {"oak_sapling.png"},
	inventory_image = "oak_sapling.png",
	wield_image = "oak_sapling.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	on_timer = grow_new_oak_tree,
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
			"oak:sapling",
			-- minp, maxp to be checked, relative to sapling pos
			-- minp_relative.y = 1 because sapling pos has been checked
			{x = -2, y = 1, z = -2},
			{x = 2, y = 6, z = 2},
			-- maximum interval of interior volume check
			4)

		return itemstack
	end,
})
local function grow_new_oak_tree(pos)
	if not default.can_grow(pos) then
		-- try a bit later again
		minetest.get_node_timer(pos):start(math.random(240, 600))
		return
	end
	minetest.remove_node(pos)
	minetest.place_schematic({x = pos.x-5, y = pos.y, z = pos.z-5}, modpath.."/schematics/oak.mts", "0", nil, false)
end
if minetest.global_exists("flowerpot") then
	flowerpot.register_node("oak:sapling")
end

if minetest.settings:get_bool("cool_fences", true) then
	local fence = {
		description = S("Oak Wood Fence"),
		texture =  "oak_wood.png",
		material = "oak:wood",
		groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
		sounds = default.node_sound_wood_defaults(),
	}
	default.register_fence("oak:fence", table.copy(fence))
	fence.description = S("Oak Fence Rail")
	default.register_fence_rail("oak:fence_rail", table.copy(fence))

	if minetest.get_modpath("doors") ~= nil then
		fence.description = S("Oak Fence Gate")
		doors.register_fencegate("oak:gate", table.copy(fence))
	end
end

if mg_name ~= "v6" and mg_name ~= "singlenode" then

	if minetest.get_modpath("rainf") then
		place_on = "rainf:meadow"
		biomes = "rainf"
		offset = 0.0008
		scale = 0.00004
	else
		place_on = "default:dirt_with_grass"
		biomes = "grassland"
		offset = 0.0008
		scale = 0.00004
	end

	minetest.register_decoration({
		name = "oak:oak_tree",
		deco_type = "schematic",
		place_on = {place_on},
		sidelen = 16,
		noise_params = {
			offset = offset,
			scale = scale,
			spread = {x = 250, y = 250, z = 250},
			seed = 6431,
			octaves = 3,
			persist = 0.66
		},
		biomes = {biomes},
		y_min = 1,
		y_max = 80,
		schematic = modpath.."/schematics/oak.mts",
		flags = "place_center_x, place_center_z,  force_placement",
		rotation = "random",
		place_offset_y = 0,
	})
end
]]--
