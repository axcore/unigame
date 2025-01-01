---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_ethereal_grass_ordinary = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_ethereal_grass_ordinary.init()

    return {
        description = "Ordinary grass as decoration",
        depends = {"dirt_ordinary", "grass_ordinary"},
        at_least_one = {
            {
                "biome_ethereal_bamboo",
                "biome_ethereal_forest_deciduous",
                "biome_ethereal_grassy",
                "biome_ethereal_grove",
                "biome_ethereal_jumble",
                "biome_ethereal_mediterranean",
                "biome_ethereal_prairie",
                "biome_ethereal_rainforest",
            },
            {
                "dirt_ordinary_with_turf_bamboo",
                "dirt_ordinary_with_turf_grove",
                "dirt_ordinary_with_turf_rainforest",
                "dirt_ordinary_with_turf_prairie",
            },
        },
    }

end

function unilib.pkg.deco_ethereal_grass_ordinary.exec()

    unilib.register_decoration_generic("ethereal_grass_ordinary", {
        -- From ethereal-ng/decor.lua
        deco_type = "simple",
        decoration = {
            "unilib:grass_ordinary_2",
            "unilib:grass_ordinary_3",
            "unilib:grass_ordinary_4",
            "unilib:grass_ordinary_5",
        },

        fill_ratio = 0.35,
        sidelen = 80,
    })

end

function unilib.pkg.deco_ethereal_grass_ordinary.post()

    unilib.register_decoration_complete("ethereal_grass_ordinary", nil, {
        -- From ethereal-ng/decor.lua
        biomes = {
            "ethereal_bamboo",
            "ethereal_forest_deciduous",
            "ethereal_grassland",
            "ethereal_grassy",
            "ethereal_grove",
            "ethereal_jumble",
            "ethereal_mediterranean",
            "ethereal_prairie",
            "ethereal_rainforest",
            "ethereal_swamp",
        },
        place_on = {
            "unilib:dirt_ordinary_with_litter_rainforest",
            "unilib:dirt_ordinary_with_turf",
            "unilib:dirt_ordinary_with_turf_bamboo",
            "unilib:dirt_ordinary_with_turf_grove",
            "unilib:dirt_ordinary_with_turf_prairie",
        },
        y_max = 100,
        y_min = 1,
    })

end
