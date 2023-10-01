---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_craftitem("farming:pumpkin_slice", {
	description = S("Pumpkin Slice"),
	inventory_image = "farming_pumpkin_slice.png",
	groups = {seed = 2, food_pumpkin_slice = 1, flammable = 2},
	on_place = function(itemstack, placer, pointed_thing)
		return farming.place_seed(itemstack, placer, pointed_thing, "farming:pumpkin_1")
	end,
	on_use = minetest.item_eat(2)
})
minetest.register_craft({
	output = "farming:pumpkin",
	recipe = {
		{"farming:pumpkin_slice", "farming:pumpkin_slice"},
		{"farming:pumpkin_slice", "farming:pumpkin_slice"}
	}
})
minetest.register_craft({
	output = "farming:pumpkin_slice 4",
	recipe = {{"farming:cutting_board", "farming:pumpkin"}},
	replacements = {{"farming:cutting_board", "farming:cutting_board"}}
})

-- pumpkin definition
local def = {
	drawtype = "plantlike",
	tiles = {"farming_pumpkin_1.png"},
	paramtype = "light",
	sunlight_propagates = true,
	waving = 1,
	walkable = false,
	buildable_to = true,
	drop = "",
	selection_box = farming.select,
	groups = {
		snappy = 3, flammable = 2, plant = 1, attached_node = 1,
		not_in_creative_inventory = 1, growing = 1
	},
	sounds = default.node_sound_leaves_defaults()
}
-- stage 1
minetest.register_node("farming:pumpkin_1", table.copy(def))
-- stage 2
def.tiles = {"farming_pumpkin_2.png"}
minetest.register_node("farming:pumpkin_2", table.copy(def))
-- stage 3
def.tiles = {"farming_pumpkin_3.png"}
minetest.register_node("farming:pumpkin_3", table.copy(def))
-- stage 4
def.tiles = {"farming_pumpkin_4.png"}
minetest.register_node("farming:pumpkin_4", table.copy(def))
-- stage 5
def.tiles = {"farming_pumpkin_5.png"}
minetest.register_node("farming:pumpkin_5", table.copy(def))
-- stage 6
def.tiles = {"farming_pumpkin_6.png"}
minetest.register_node("farming:pumpkin_6", table.copy(def))
-- stage 7
def.tiles = {"farming_pumpkin_7.png"}
minetest.register_node("farming:pumpkin_7", table.copy(def))
-- stage 8 (final)
minetest.register_node("farming:pumpkin_8", {
	description = S("Pumpkin"),
	tiles = {
		"farming_pumpkin_top.png",
		"farming_pumpkin_bottom.png",
		"farming_pumpkin_side.png"
	},
	groups = {
		food_pumpkin = 1, choppy = 2, oddly_breakable_by_hand = 1,
		flammable = 2, plant = 1
	},
	drop = "farming:pumpkin_8",
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir",
	on_place = minetest.rotate_node
})
minetest.register_alias("farming:pumpkin", "farming:pumpkin_8")

farming.registered_plants["farming:pumpkin"] = {
	crop = "farming:pumpkin",
	seed = "farming:pumpkin_slice",
	minlight = farming.min_light,
	maxlight = farming.max_light,
	steps = 8
}

local function register_plant(name, min, max, spawnon, spawnby, num, rarety)

	-- do not place on mapgen if no value given (or not true)
	if not rarety then
		return
	end

	-- set rarety value or default to farming.rarety if not a number
	rarety = tonumber(rarety) or farming.rarety

	minetest.register_decoration({
		deco_type = "simple",
		place_on = spawnon or {"default:dirt_with_grass"},
		sidelen = 16,
		noise_params = {
			offset = 0,
			scale = rarety,
			spread = {x = 100, y = 100, z = 100},
			seed = 329,
			octaves = 3,
			persist = 0.6
		},
		y_min = min,
		y_max = max,
		decoration = "farming:" .. name,
		spawn_by = spawnby,
		num_spawn_by = num
	})
end
register_plant("pumpkin_8", 1, 6, nil, "", -1, farming.pumpkin)
]]--
