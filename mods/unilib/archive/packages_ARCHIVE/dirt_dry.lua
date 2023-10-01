---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
--
-- From:    farming
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("default:dry_dirt", {
	description = S("Savanna Dirt"),
	tiles = {"default_dry_dirt.png"},
	groups = {crumbly = 3, soil = 1},
	sounds = default.node_sound_dirt_defaults(),
})
minetest.override_item("default:dry_dirt", {
	soil = {
		base = "default:dry_dirt",
		dry = "farming:dry_soil",
		wet = "farming:dry_soil_wet"
	}
})

-- Savanna bare dirt patches.
-- Must come before all savanna decorations that are placed on dry grass.
-- Noise is similar to long dry grass noise, but scale inverted, to appear
-- where long dry grass is least dense and shortest.
minetest.register_decoration({
    deco_type = "simple",
    place_on = {"default:dry_dirt_with_dry_grass"},
    sidelen = 4,
    noise_params = {
        offset = -1.5,
        scale = -1.5,
        spread = {x = 200, y = 200, z = 200},
        seed = 329,
        octaves = 4,
        persist = 1.0
    },
    biomes = {"savanna"},
    y_max = 31000,
    y_min = 1,
    decoration = "default:dry_dirt",
    place_offset_y = -1,
    flags = "force_placement",
})

minetest.register_node("default:dry_dirt_with_dry_grass", {
	description = S("Savanna Dirt with Savanna Grass"),
	tiles = {"default_dry_grass.png", "default_dry_dirt.png",
		{name = "default_dry_dirt.png^default_dry_grass_side.png",
			tileable_vertical = false}},
	groups = {crumbly = 3, soil = 1},
	drop = "default:dry_dirt",
	sounds = default.node_sound_dirt_defaults({
		footstep = {name = "default_grass_footstep", gain = 0.4},
	}),
})
minetest.override_item("default:dry_dirt_with_dry_grass", {
	soil = {
		base = "default:dry_dirt_with_dry_grass",
		dry = "farming:dry_soil",
		wet = "farming:dry_soil_wet"
	}
})
]]--
