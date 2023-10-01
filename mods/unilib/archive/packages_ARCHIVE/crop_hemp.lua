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
minetest.register_node("farming:seed_hemp", {
	description = S("Hemp Seed"),
	tiles = {"farming_hemp_seed.png"},
	inventory_image = "farming_hemp_seed.png",
	wield_image = "farming_hemp_seed.png",
	drawtype = "signlike",
	groups = {seed = 1, snappy = 3, attached_node = 1},
	paramtype = "light",
	paramtype2 = "wallmounted",
	walkable = false,
	sunlight_propagates = true,
	selection_box = farming.select,
	on_place = function(itemstack, placer, pointed_thing)
		return farming.place_seed(itemstack, placer, pointed_thing, "farming:hemp_1")
	end
})

minetest.register_craftitem("farming:hemp_leaf", {
	description = S("Hemp Leaf"),
	inventory_image = "farming_hemp_leaf.png"
})

local def = {
	drawtype = "plantlike",
	tiles = {"farming_hemp_1.png"},
	paramtype = "light",
	sunlight_propagates = true,
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
minetest.register_node("farming:hemp_1", table.copy(def))
-- stage 2
def.tiles = {"farming_hemp_2.png"}
minetest.register_node("farming:hemp_2", table.copy(def))
-- stage 3
def.tiles = {"farming_hemp_3.png"}
minetest.register_node("farming:hemp_3", table.copy(def))
-- stage 4
def.tiles = {"farming_hemp_4.png"}
minetest.register_node("farming:hemp_4", table.copy(def))
-- stage 5
def.tiles = {"farming_hemp_5.png"}
minetest.register_node("farming:hemp_5", table.copy(def))
-- stage 6
def.tiles = {"farming_hemp_6.png"}
def.drop = {
	items = {
		{items = {"farming:hemp_leaf"}, rarity = 2},
		{items = {"farming:seed_hemp"}, rarity = 1}
	}
}
minetest.register_node("farming:hemp_6", table.copy(def))
-- stage 7
def.tiles = {"farming_hemp_7.png"}
def.drop = {
	items = {
		{items = {"farming:hemp_leaf"}, rarity = 1},
		{items = {"farming:hemp_leaf"}, rarity = 3},
		{items = {"farming:seed_hemp"}, rarity = 1},
		{items = {"farming:seed_hemp"}, rarity = 3}
	}
}
minetest.register_node("farming:hemp_7", table.copy(def))
-- stage 8 (final)
def.tiles = {"farming_hemp_8.png"}
def.groups.growing = nil
def.drop = {
	items = {
		{items = {"farming:hemp_leaf 2"}, rarity = 1},
		{items = {"farming:hemp_leaf"}, rarity = 2},
		{items = {"farming:seed_hemp"}, rarity = 1},
		{items = {"farming:seed_hemp"}, rarity = 2}
	}
}
minetest.register_node("farming:hemp_8", table.copy(def))

-- add to registered_plants
farming.registered_plants["farming:hemp"] = {
	crop = "farming:hemp",
	seed = "farming:seed_hemp",
	mminlight = farming.min_light,
	maxlight = farming.max_light,
	steps = 8
}

if farming.hemp then
    minetest.register_decoration({
        deco_type = "simple",
        place_on = {"default:dirt_with_grass", "default:dirt_with_rainforest_litter"},
        sidelen = 16,
        noise_params = {
            offset = 0,
            scale = tonumber(farming.hemp) or farming.rarety,
            spread = {x = 100, y = 100, z = 100},
            seed = 420,
            octaves = 3,
            persist = 0.6
        },
        y_min = 3,
        y_max = 45,
        decoration = "farming:hemp_7",
        spawn_by = "group:tree",
        num_spawn_by = 1
    })
end
]]--
