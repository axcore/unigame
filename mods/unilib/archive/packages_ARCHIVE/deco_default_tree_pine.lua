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
minetest.register_decoration({
    name = "default:pine_tree",
    deco_type = "schematic",
    place_on = {"default:dirt_with_snow", "default:dirt_with_coniferous_litter"},
    sidelen = 16,
    noise_params = {
        offset = 0.010,
        scale = 0.048,
        spread = {x = 250, y = 250, z = 250},
        seed = 2,
        octaves = 3,
        persist = 0.66
    },
    biomes = {"taiga", "coniferous_forest"},
    y_max = 31000,
    y_min = 4,
    schematic = minetest.get_modpath("default") .. "/schematics/pine_tree.mts",
    flags = "place_center_x, place_center_z",
})

minetest.register_decoration({
    name = "default:small_pine_tree",
    deco_type = "schematic",
    place_on = {"default:dirt_with_snow", "default:dirt_with_coniferous_litter"},
    sidelen = 16,
    noise_params = {
        offset = 0.010,
        scale = -0.048,
        spread = {x = 250, y = 250, z = 250},
        seed = 2,
        octaves = 3,
        persist = 0.66
    },
    biomes = {"taiga", "coniferous_forest"},
    y_max = 31000,
    y_min = 4,
    schematic = minetest.get_modpath("default") .. "/schematics/small_pine_tree.mts",
    flags = "place_center_x, place_center_z",
})
]]--
