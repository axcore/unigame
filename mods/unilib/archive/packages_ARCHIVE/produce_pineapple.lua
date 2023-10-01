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
minetest.register_node("farming:pineapple", {
	description = S("Pineapple"),
	drawtype = "plantlike",
	tiles = {"farming_pineapple.png"},
	inventory_image = "farming_pineapple.png",
	wield_image = "farming_pineapple.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.27, -0.37, -0.27, 0.27, 0.44, 0.27}
	},
	groups = {food_pineapple = 1, fleshy = 3, dig_immediate = 3, flammable = 2}
})

minetest.register_craftitem("farming:pineapple_top", {
	description = S("Pineapple Top"),
	inventory_image = "farming_pineapple_top.png",
	groups = {seed = 2, flammable = 2},
	on_place = function(itemstack, placer, pointed_thing)
		return farming.place_seed(itemstack, placer, pointed_thing, "farming:pineapple_1")
	end
})

minetest.register_craftitem("farming:pineapple_ring", {
	description = S("Pineapple Ring"),
	inventory_image = "farming_pineapple_ring.png",
	groups = {food_pineapple_ring = 1, flammable = 2},
	on_use = minetest.item_eat(1)
})
minetest.register_craft( {
	output = "farming:pineapple_ring 5",
	recipe = {{"group:food_pineapple"}},
	replacements = {{"farming:pineapple", "farming:pineapple_top"}}
})

local def = {
	drawtype = "plantlike",
	visual_scale = 1.5,
	tiles = {"farming_pineapple_1.png"},
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
minetest.register_node("farming:pineapple_1", table.copy(def))
-- stage 2
def.tiles = {"farming_pineapple_2.png"}
minetest.register_node("farming:pineapple_2", table.copy(def))
-- stage 3
def.tiles = {"farming_pineapple_3.png"}
minetest.register_node("farming:pineapple_3", table.copy(def))
-- stage 4
def.tiles = {"farming_pineapple_4.png"}
minetest.register_node("farming:pineapple_4", table.copy(def))
-- stage 5
def.tiles = {"farming_pineapple_5.png"}
minetest.register_node("farming:pineapple_5", table.copy(def))
-- stage 6
def.tiles = {"farming_pineapple_6.png"}
minetest.register_node("farming:pineapple_6", table.copy(def))
-- stage 7
def.tiles = {"farming_pineapple_7.png"}
minetest.register_node("farming:pineapple_7", table.copy(def))
-- stage 8 (final)
def.tiles = {"farming_pineapple_8.png"}
def.groups.growing = nil
def.drop = {
	items = {
		{items = {"farming:pineapple"}, rarity = 1},
		{items = {"farming:pineapple"}, rarity = 10}
	}
}
minetest.register_node("farming:pineapple_8", table.copy(def))

-- add to registered_plants
farming.registered_plants["farming:pineapple"] = {
	crop = "farming:pineapple",
	seed = "farming:pineapple_top",
	minlight = farming.min_light,
	maxlight = farming.max_light,
	steps = 8
}

if farming.pineapple then

    tmp1 = {"default:dirt_with_dry_grass", "default:dry_dirt_with_dry_grass"}
    tmp2 = nil
    tmp3 = -1

    if mg_name == "v6" then
        tmp1 = {"default:dirt_with_grass"}
        tmp2 = "default:desert_sand"
        tmp3 = 1
    end

    minetest.register_decoration({
        deco_type = "simple",
        place_on = tmp1,
        sidelen = 16,
        noise_params = {
            offset = 0,
            scale = tonumber(farming.pineapple) or farming.rarety,
            spread = {x = 100, y = 100, z = 100},
            seed = 917,
            octaves = 3,
            persist = 0.6
        },
        y_min = 18,
        y_max = 30,
        decoration = {"farming:pineapple_8"},
        spawn_by = tmp2,
        num_spawn_by = tmp3
    })
end
]]--