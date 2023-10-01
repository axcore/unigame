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
minetest.register_craftitem("farming:seed_mint", {
	description = S("Mint Seeds"),
	inventory_image = "farming_mint_seeds.png",
	groups = {seed = 2, flammable = 2},
	on_place = function(itemstack, placer, pointed_thing)
		return farming.place_seed(
				itemstack, placer, pointed_thing, "farming:mint_1")
	end
})

minetest.register_craftitem("farming:mint_leaf", {
	description = S("Mint Leaf"),
	inventory_image = "farming_mint_leaf.png",
	groups = {food_mint = 1, flammable = 4}
})

local def = {
	drawtype = "plantlike",
	tiles = {"farming_mint_1.png"},
	paramtype = "light",
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
minetest.register_node("farming:mint_1", table.copy(def))

-- stage 2
def.tiles = {"farming_mint_2.png"}
minetest.register_node("farming:mint_2", table.copy(def))

-- stage 3
def.tiles = {"farming_mint_3.png"}
minetest.register_node("farming:mint_3", table.copy(def))

-- stage 4 (final)
def.tiles = {"farming_mint_4.png"}
def.groups.growing = nil
def.drop = {
	items = {
		{items = {"farming:mint_leaf 2"}, rarity = 1},
		{items = {"farming:mint_leaf 2"}, rarity = 2},
		{items = {"farming:seed_mint 1"}, rarity = 1},
		{items = {"farming:seed_mint 2"}, rarity = 2}
	}
}
minetest.register_node("farming:mint_4", table.copy(def))

-- add to registered_plants
farming.registered_plants["farming:mint"] = {
	crop = "farming:mint",
	seed = "farming:seed_mint",
	minlight = farming.min_light,
	maxlight = farming.max_light,
	steps = 4
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
register_plant("mint_4", 1, 75, {
	"default:dirt_with_grass", "default:dirt_with_coniferous_litter"},
	"group:water", 1, farming.mint)
]]--
