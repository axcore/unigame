---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_ethereal_misc_firefly = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_ethereal_misc_firefly.init()

    return {
        description = "Fireflies as decoration",
        depends = "misc_firefly",
        at_least_one = {
            {
                "biome_ethereal_forest_coniferous",
                "biome_ethereal_forest_deciduous",
                "biome_ethereal_grassy",
                "biome_ethereal_rainforest",
                "biome_ethereal_swamp",
            },
            {
                "dirt_ordinary",
                "dirt_ordinary_with_turf_cold",
            },
        },
    }

end

function unilib.pkg.deco_ethereal_misc_firefly.exec()

    if unilib.pkg_executed_table["dirt_ordinary"] ~= nil or
            unilib.pkg_executed_table["dirt_ordinary_with_turf_cold"] ~= nil then

        unilib.register_decoration("ethereal_misc_firefly", {
            -- From ethereal-ng/decor.lua
            deco_type = "simple",
            decoration = "unilib:misc_firefly_hidden",

            fill_ratio = 0.0005,
            place_offset_y = 2,
            sidelen = 80,
        })

    end

end

function unilib.pkg.deco_ethereal_misc_firefly.post()

    if unilib.pkg_executed_table["dirt_ordinary"] ~= nil or
            unilib.pkg_executed_table["dirt_ordinary_with_turf_cold"] ~= nil then

        unilib.register_decoration_now("ethereal_misc_firefly", nil, {
            -- From ethereal-ng/decor.lua
            biomes = {
                "ethereal_forest_coniferous",
                "ethereal_forest_deciduous",
                "ethereal_grassy",
                "ethereal_rainforest",
                "ethereal_swamp",
            },
            place_on = {
                "unilib:dirt_ordinary",
                "unilib:dirt_ordinary_with_litter_coniferous",
                "unilib:dirt_ordinary_with_litter_rainforest",
                "unilib:dirt_ordinary_with_turf",
                "unilib:dirt_ordinary_with_turf_cold",
            },
            y_max = unilib.y_max,
            y_min = -1,
        })

    end

end
