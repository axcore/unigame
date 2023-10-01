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
-- Dirt version for rainforest swamp
minetest.register_decoration({
    name = "default:papyrus_on_dirt",
    deco_type = "schematic",
    place_on = {"default:dirt"},
    sidelen = 16,
    noise_params = {
        offset = -0.3,
        scale = 0.7,
        spread = {x = 200, y = 200, z = 200},
        seed = 354,
        octaves = 3,
        persist = 0.7
    },
    biomes = {"rainforest_swamp"},
    y_max = 0,
    y_min = 0,
    schematic = minetest.get_modpath("default") .. "/schematics/papyrus_on_dirt.mts",
})

-- Dry dirt version for savanna shore
minetest.register_decoration({
    name = "default:papyrus_on_dry_dirt",
    deco_type = "schematic",
    place_on = {"default:dry_dirt"},
    sidelen = 16,
    noise_params = {
        offset = -0.3,
        scale = 0.7,
        spread = {x = 200, y = 200, z = 200},
        seed = 354,
        octaves = 3,
        persist = 0.7
    },
    biomes = {"savanna_shore"},
    y_max = 0,
    y_min = 0,
    schematic = minetest.get_modpath("default") ..
        "/schematics/papyrus_on_dry_dirt.mts",
})
]]--
