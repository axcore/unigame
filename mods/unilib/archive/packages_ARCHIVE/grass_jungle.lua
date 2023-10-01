---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
--
-- From:    farming
-- Code:    MIT
-- Media:   CC BY 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("default:junglegrass", {
	description = S("Jungle Grass"),
	drawtype = "plantlike",
	waving = 1,
	visual_scale = 1.69,
	tiles = {"default_junglegrass.png"},
	inventory_image = "default_junglegrass.png",
	wield_image = "default_junglegrass.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	groups = {snappy = 3, flora = 1, attached_node = 1, grass = 1, junglegrass = 1, flammable = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, 0.5, 6 / 16},
	},
})
minetest.register_craft({
	type = "fuel",
	recipe = "default:junglegrass",
	burntime = 3,
})

minetest.register_decoration({
    name = "default:junglegrass",
    deco_type = "simple",
    place_on = {"default:dirt_with_rainforest_litter"},
    sidelen = 80,
    fill_ratio = 0.1,
    biomes = {"rainforest"},
    y_max = 31000,
    y_min = 1,
    decoration = "default:junglegrass",
})

-- This is the old source of cotton seeds that makes no sense. It is a leftover
-- from Mapgen V6 where junglegrass was the only plant available to be a source.
-- This source is kept for now to avoid disruption but should probably be
-- removed in future as players get used to the new source.
minetest.override_item("default:junglegrass", {drop = {
	max_items = 1,
	items = {
		{items = {"farming:seed_cotton"}, rarity = 8},
		{items = {"default:junglegrass"}},
	}
}})
]]--

--[[
minetest.override_item("default:junglegrass", {
	drop = {
		max_items = 1,
		items = {
			{items = {"farming:seed_cotton"}, rarity = 8},
			{items = {"farming:seed_rice"},rarity = 8},
			{items = {"default:junglegrass"}}
		}
	}
})
]]--
