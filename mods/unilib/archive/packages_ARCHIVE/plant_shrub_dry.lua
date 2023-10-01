---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("default:dry_shrub", {
	description = S("Dry Shrub"),
	drawtype = "plantlike",
	waving = 1,
	tiles = {"default_dry_shrub.png"},
	inventory_image = "default_dry_shrub.png",
	wield_image = "default_dry_shrub.png",
	paramtype = "light",
	paramtype2 = "meshoptions",
	place_param2 = 4,
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	groups = {snappy = 3, flammable = 3, attached_node = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, 4 / 16, 6 / 16},
	},
})
minetest.register_craft({
	type = "fuel",
	recipe = "default:dry_shrub",
	burntime = 2,
})

minetest.register_decoration({
    name = "default:dry_shrub",
    deco_type = "simple",
    place_on = {"default:desert_sand",
        "default:sand", "default:silver_sand"},
    sidelen = 16,
    noise_params = {
        offset = 0,
        scale = 0.02,
        spread = {x = 200, y = 200, z = 200},
        seed = 329,
        octaves = 3,
        persist = 0.6
    },
    biomes = {"desert", "sandstone_desert", "cold_desert"},
    y_max = 31000,
    y_min = 2,
    decoration = "default:dry_shrub",
    param2 = 4,
})
]]--
