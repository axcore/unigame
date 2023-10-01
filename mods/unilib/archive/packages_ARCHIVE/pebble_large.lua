---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plantlife/cavestuff
-- Code:    LGPL v3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
local cbox = {
	type = "fixed",
	fixed = {-5/16, -8/16, -6/16, 5/16, -1/32, 5/16},
}

minetest.register_node("cavestuff:desert_pebble_1",{
	description = S("Desert Pebble"),
	drawtype = "mesh",
	mesh = "cavestuff_pebble.obj",
	 tiles = {"default_desert_stone.png"},
	 paramtype = "light",
	paramtype2 = "facedir",
	 groups = {cracky=3, stone=1, attached_node=1},
	selection_box = cbox,
	collision_box = cbox,
	 on_place = function(itemstack, placer, pointed_thing)
		-- place a random pebble node
		local stack = ItemStack("cavestuff:desert_pebble_"..math.random(1,2))
		local ret = minetest.item_place(stack, placer, pointed_thing)
		return ItemStack("cavestuff:desert_pebble_1 "..itemstack:get_count()-(1-ret:get_count()))
	end,
	 sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("cavestuff:desert_pebble_2",{
	drawtype = "mesh",
	mesh = "cavestuff_pebble.obj",
	drop = "cavestuff:desert_pebble_1",
	 tiles = {"default_desert_stone.png"},
	 paramtype = "light",
	paramtype2 = "facedir",
	 groups = {cracky=3, stone=1, attached_node=1, not_in_creative_inventory=1},
	selection_box = cbox,
	collision_box = cbox,
	 sounds = default.node_sound_stone_defaults(),
})

biome_lib.register_on_generate(
	{
		surface = {
			"default:desert_sand",
			"default:desert_stone"
		},
		max_count = 50,
		rarity = 0,
		plantlife_limit = -1,
		check_air = true,
		random_facedir = {0, 3}
	},
	{
		"cavestuff:desert_pebble_1",
		"cavestuff:desert_pebble_2"
	}
)

local cbox = {
	type = "fixed",
	fixed = {-5/16, -8/16, -6/16, 5/16, -1/32, 5/16},
}

minetest.register_node("cavestuff:pebble_1",{
	description = S("Pebble"),
	drawtype = "mesh",
	mesh = "cavestuff_pebble.obj",
	 tiles = {"undergrowth_pebble.png"},
	 paramtype = "light",
	paramtype2 = "facedir",
	 groups = {cracky=3, stone=1, attached_node=1},
	 selection_box = cbox,
	 collision_box = cbox,
	 on_place = function(itemstack, placer, pointed_thing)
		-- place a random pebble node
		local stack = ItemStack("cavestuff:pebble_"..math.random(1,2))
		local ret = minetest.item_place(stack, placer, pointed_thing)
		return ItemStack("cavestuff:pebble_1 "..itemstack:get_count()-(1-ret:get_count()))
	end,
	 sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("cavestuff:pebble_2",{
	drawtype = "mesh",
	mesh = "cavestuff_pebble.obj",
	 tiles = {"undergrowth_pebble.png"},
	drop = "cavestuff:pebble_1",
	 tiles = {"undergrowth_pebble.png"},
	 paramtype = "light",
	paramtype2 = "facedir",
	 groups = {cracky=3, stone=1, attached_node=1, not_in_creative_inventory=1},
	selection_box = cbox,
	collision_box = cbox,
	 sounds = default.node_sound_stone_defaults(),
})

biome_lib.register_on_generate(
	{
		surface = {
			"default:dirt_with_grass",
			"default:gravel",
			"default:stone",
			"default:permafrost_with_stones"
		},
		max_count = 50,
		rarity = 0,
		plantlife_limit = -1,
		check_air = true,
		random_facedir = {0, 3}
	},
	{
		"cavestuff:pebble_1",
		"cavestuff:pebble_2"
	}
)
]]--
