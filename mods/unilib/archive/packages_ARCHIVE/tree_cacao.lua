---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cool_trees/cacaotree
-- Code:    GPLv3
-- Media:   GPLv3
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("cacaotree:flower_creeper", {
	description = S("Cacaotree Flower Creeper"),
	drawtype = "nodebox",
	walkable = true,
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = {"cacaotree_flower_creeper.png"},
	inventory_image = "cacaotree_flower_creeper.png",
	wield_image = "cacaotree_flower_creeper.png",
	use_texture_alpha = "clip",
	node_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, 0.49, 0.5, 0.5, 0.5}
	},
	groups = {
		snappy = 2, flammable = 3, oddly_breakable_by_hand = 3, choppy = 2, carpet = 1, leafdecay = 3, leaves = 1
	},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("cacaotree:liana", {
	description = S("Cacao Tree Liana"),
	drawtype = "nodebox",
	walkable = true,
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = {"cacaotree_liana.png"},
	inventory_image = "cacaotree_liana.png",
	wield_image = "cacaotree_liana.png",
	use_texture_alpha = "clip",
	node_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, 0.0, 0.5, 0.5, 0.0}
	},
	groups = {
		snappy = 2, flammable = 3, oddly_breakable_by_hand = 3, choppy = 2, carpet = 1, leafdecay = 3, leaves = 1,
	},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("cacaotree:pod", {
	description = S("Cacao Pod"),
	drawtype = "nodebox",
	tiles = {
		"cacaotree_bean_top.png",
		"cacaotree_bean_top.png^[transformFY",
		"cacaotree_bean_right.png",
		"cacaotree_bean_right.png^[transformFX",
		"cacaotree_bean_front.png",
	},
	paramtype = "light",
	paramtype2 = "wallmounted",
	node_box = {
	type = "fixed",
		fixed = {
			{-0.25, -0.5, 0, 0.25, 0.0625, 0.5},
		},
	},
	use_texture_alpha = "clip",
	drop = "cacaotree:cacao_beans 10",
	groups = {fleshy = 3, dig_immediate = 3, flammable = 2,
		leafdecay = 3, leafdecay_drop = 1},
	sounds = default.node_sound_leaves_defaults(),
	walkable = false,
	is_ground_content = false,
})

minetest.register_node("cacaotree:trunk", {
	description = S("Cacao Tree Trunk"),
	tiles = {
		"cacaotree_trunk_top.png",
		"cacaotree_trunk_top.png",
		"cacaotree_trunk.png"
	},
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir",
	on_place = minetest.rotate_node,
})
minetest.register_craft({
	type = "fuel",
	recipe = "cacaotree:trunk",
	burntime = 30,
})

minetest.register_node("cacaotree:wood", {
	description = S("Cacao Tree Wood"),
	tiles = {"cacaotree_wood.png"},
	is_ground_content = false,
	groups = {wood = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
})
minetest.register_craft({
	output = "cacaotree:wood 4",
	recipe = {{"cacaotree:trunk"}}
})
minetest.register_craft({
	type = "fuel",
	recipe = "cacaotree:wood",
	burntime = 7,
})
if minetest.get_modpath("stairs") ~= nil then
	stairs.register_stair_and_slab(
		"cacaotree_trunk",
		"cacaotree:trunk",
		{choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
		{"cacaotree_wood.png"},
		S("Cacao Tree Stair"),
		S("Cacao Tree Slab"),
		default.node_sound_wood_defaults()
	)
end
if minetest.get_modpath("moreblocks") then
	stairsplus:register_all("cacaotree", "wood", "cacaotree:wood", {
		description = "Cacao Tree",
		tiles = {"cacaotree_wood.png"},
		groups = {choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
		sounds = default.node_sound_wood_defaults(),
	})
end

minetest.register_node("cacaotree:leaves", {
	description = S("Cacao Tree Leaves"),
	drawtype = "allfaces_optional",
	tiles = {"cacaotree_leaves.png"},
	paramtype = "light",
	walkable = true,
	waving = 1,
	groups = {snappy = 3, leafdecay = 3, leaves = 1, flammable = 2},
	drop = {
		max_items = 1,
		items = {
			{items = {"cacaotree:sapling"}, rarity = 12},
			{items = {"cacaotree:leaves"}}
		}
	},
	sounds = default.node_sound_leaves_defaults(),
	after_place_node = default.after_place_leaves,
})
default.register_leafdecay({
	trunks = {"cacaotree:trunk"},
	leaves = {"cacaotree:leaves"},
	radius = 3,
})

minetest.register_node("cacaotree:sapling", {
	description = S("Cacao Tree Sapling"),
	drawtype = "plantlike",
	tiles = {"cacaotree_sapling.png"},
	inventory_image = "cacaotree_sapling.png",
	wield_image = "cacaotree_sapling.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	on_timer = grow_new_cacao_tree,
	selection_box = {
		type = "fixed",
		fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16}
	},
	groups = {snappy = 2, dig_immediate = 3, flammable = 2,
		attached_node = 1, sapling = 1},
	sounds = default.node_sound_leaves_defaults(),

	on_construct = function(pos)
		minetest.get_node_timer(pos):start(math.random(grow_time_min, grow_time_max))
	end,

	on_place = function(itemstack, placer, pointed_thing)
		itemstack = default.sapling_on_place(itemstack, placer, pointed_thing,
			"cacaotree:sapling",
			-- minp, maxp to be checked, relative to sapling pos
			-- minp_relative.y = 1 because sapling pos has been checked
			{x = -2, y = 1, z = -2},
			{x = 2, y = 6, z = 2},
			-- maximum interval of interior volume check
			4)

		return itemstack
	end,
})
local function grow_new_cacao_tree(pos)
	if not default.can_grow(pos) then
		-- try a bit later again
		minetest.get_node_timer(pos):start(math.random(retry_grow_time_min, retry_grow_time_max))
		return
	end
	minetest.remove_node(pos)
	minetest.place_schematic({x = pos.x-2, y = pos.y, z = pos.z-2}, modpath.."/schematics/cacaotree.mts", "0", nil, false)
end
if minetest.global_exists("flowerpot") then
	flowerpot.register_node("cacaotree:sapling")
end

if minetest.settings:get_bool("cool_fences", true) then
	local fence = {
		description = S("Cacao Tree Wood Fence"),
		texture =  "cacaotree_wood.png",
		material = "cacaotree:wood",
		groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
		sounds = default.node_sound_wood_defaults(),
	}
	default.register_fence("cacaotree:fence", table.copy(fence))
	fence.description = S("Cacao Tree Fence Rail")
	default.register_fence_rail("cacaotree:fence_rail", table.copy(fence))

	if minetest.get_modpath("doors") ~= nil then
		fence.description = S("Cacao Tree Fence Gate")
		doors.register_fencegate("cacaotree:gate", table.copy(fence))
	end
end

if mg_name ~= "v6" and mg_name ~= "singlenode" then

	minetest.register_decoration({
		name = "cacao:cacaotree",
		deco_type = "schematic",
		place_on = {"default:dirt_with_rainforest_litter"},
		sidelen = 16,
		noise_params = {
			offset = 0.001,
			scale = 0.001,
			spread = {x = 250, y = 250, z = 250},
			seed = 6431,
			octaves = 3,
			persist = 0.66
		},
		biomes = {"rainforest"},
		y_min = 1,
		y_max = 31000,
		schematic = modpath.."/schematics/cacaotree.mts",
		flags = "place_center_x, place_center_z, force_placement",
		rotation = "random",
		place_offset_y = 1,
	})
end
]]--
