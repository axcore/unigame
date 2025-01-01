---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_ethereal_mushroom_mixed = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_ethereal_mushroom_mixed.init()

    return {
        description = "Brown and red mushrooms as decoration",
        depends = {"mushroom_brown", "mushroom_red"},
        at_least_one = {
            {
                "biome_ethereal_forest_deciduous",
                "biome_ethereal_grassy",
                "biome_ethereal_mushroom",
                "biome_ethereal_prairie",
                "biome_ethereal_rainforest",
                "biome_ethereal_swamp",
            },
            {
                "dirt_ordinary",
                "dirt_ordinary_with_turf_mushroom",
                "dirt_ordinary_with_turf_prairie",
            },
        },
    }

end

function unilib.pkg.deco_ethereal_mushroom_mixed.exec()

    unilib.register_decoration_generic("ethereal_mushroom_brown_red", {
        -- From ethereal-ng/decor.lua
        deco_type = "simple",
        decoration = {"unilib:mushroom_brown", "unilib:mushroom_red"},

        fill_ratio = 0.01,
        sidelen = 16,
    })

end

function unilib.pkg.deco_ethereal_mushroom_mixed.post()

    unilib.register_decoration_complete("ethereal_mushroom_brown_red", nil, {
        -- From ethereal-ng/decor.lua
        biomes = {
            "ethereal_forest_deciduous",
            "ethereal_grassy",
            "ethereal_prairie",
            "ethereal_rainforest",
            "ethereal_swamp",
            "ethereal_mushroom",
        },
        place_on = {
            "unilib:dirt_ordinary_with_litter_rainforest",
            "unilib:dirt_ordinary_with_turf",
            "unilib:dirt_ordinary_with_turf_mushroom",
            "unilib:dirt_ordinary_with_turf_prairie",
        },
        y_max = 100,
        y_min = 1,
    })

end
