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
minetest.register_craftitem("farming:chili_pepper", {
	description = S("Chili Pepper"),
	inventory_image = "farming_chili_pepper.png",
	groups = {seed = 2, food_chili_pepper = 1, flammable = 4},
	on_place = function(itemstack, placer, pointed_thing)
		return farming.place_seed(itemstack, placer, pointed_thing, "farming:chili_1")
	end,
	on_use = minetest.item_eat(2)
})

minetest.register_craft({
	output = "dye:red",
	recipe = {{"farming:chili_pepper"}}
})

local def = {
	drawtype = "plantlike",
	tiles = {"farming_chili_1.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	drop = "",
	selection_box = farming.select,
	groups = {
		snappy = 3, flammable = 4, plant = 1, attached_node = 1,
		not_in_creative_inventory = 1, growing = 1
	},
	sounds = default.node_sound_leaves_defaults()
}
-- stage 1
minetest.register_node("farming:chili_1", table.copy(def))
-- stage 2
def.tiles = {"farming_chili_2.png"}
minetest.register_node("farming:chili_2", table.copy(def))
-- stage 3
def.tiles = {"farming_chili_3.png"}
minetest.register_node("farming:chili_3", table.copy(def))
-- stage 4
def.tiles = {"farming_chili_4.png"}
minetest.register_node("farming:chili_4", table.copy(def))
-- stage 5
def.tiles = {"farming_chili_5.png"}
minetest.register_node("farming:chili_5", table.copy(def))
-- stage 6
def.tiles = {"farming_chili_6.png"}
minetest.register_node("farming:chili_6", table.copy(def))
-- stage 7
def.tiles = {"farming_chili_7.png"}
minetest.register_node("farming:chili_7", table.copy(def))
-- stage 8 (final)
def.tiles = {"farming_chili_8.png"}
def.groups.growing = nil
def.drop = {
	items = {
		{items = {"farming:chili_pepper 3"}, rarity = 1},
		{items = {"farming:chili_pepper 2"}, rarity = 2}
	}
}
minetest.register_node("farming:chili_8", table.copy(def))
-- add to registered_plants
farming.registered_plants["farming:chili_pepper"] = {
	crop = "farming:chili",
	seed = "farming:chili_pepper",
	minlight = farming.min_light,
	maxlight = farming.max_light,
	steps = 8
}

if farming.chili then
    minetest.register_decoration({
        deco_type = "simple",
        place_on = {"default:dirt_with_grass", "default:dirt_with_rainforest_litter"},
        sidelen = 16,
        noise_params = {
            offset = 0,
            scale = tonumber(farming.chili) or farming.rarety,
            spread = {x = 100, y = 100, z = 100},
            seed = 760,
            octaves = 3,
            persist = 0.6
        },
        y_min = 5,
        y_max = 35,
        decoration = {"farming:chili_8"},
        spawn_by = "group:tree",
        num_spawn_by = 1
    })
end
]]--
