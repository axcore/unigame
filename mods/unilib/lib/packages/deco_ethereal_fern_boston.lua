---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_ethereal_fern_boston = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_ethereal_fern_boston.init()

    return {
        description = "Boston fern as decoration",
        depends = "fern_boston",
        optional = {
            "biome_ethereal_frost",
            "biome_ethereal_grove",
            "biome_ethereal_swamp",
            "dirt_ordinary",
            "dirt_ordinary_with_turf_crystal",
            "dirt_ordinary_with_turf_grove",
        },
    }

end

function unilib.pkg.deco_ethereal_fern_boston.exec()

    if (
        unilib.global.pkg_executed_table["biome_ethereal_grove"] ~= nil or
        unilib.global.pkg_executed_table["biome_ethereal_swamp"] ~= nil
    ) and (
        unilib.global.pkg_executed_table["dirt_ordinary"] ~= nil or
        unilib.global.pkg_executed_table["dirt_ordinary_with_turf_grove"] ~= nil
    ) then

        unilib.register_decoration_generic("ethereal_fern_boston_1", {
            -- From ethereal-ng/decor.lua
            deco_type = "simple",
            decoration = "unilib:fern_boston",

            fill_ratio = 0.1,
            sidelen = 80,
        })

    end

    if unilib.global.pkg_executed_table["biome_ethereal_frost"] ~= nil and
            unilib.global.pkg_executed_table["dirt_ordinary_with_turf_crystal"] ~= nil then

        unilib.register_decoration_generic("ethereal_fern_boston_2", {
            -- From ethereal-ng/decor.lua
            deco_type = "simple",
            decoration = "unilib:fern_boston",

            fill_ratio = 0.001,
            sidelen = 80,
        })

    end

end

function unilib.pkg.deco_ethereal_fern_boston.post()

    if (
        unilib.global.pkg_executed_table["biome_ethereal_grove"] ~= nil or
        unilib.global.pkg_executed_table["biome_ethereal_swamp"] ~= nil
    ) and (
        unilib.global.pkg_executed_table["dirt_ordinary"] ~= nil or
        unilib.global.pkg_executed_table["dirt_ordinary_with_turf_grove"] ~= nil
    ) then

        unilib.register_decoration_complete("ethereal_fern_boston_1", nil, {
            -- From ethereal-ng/decor.lua
            biomes = {"ethereal_grove", "ethereal_swamp"},
            place_on = {
                "unilib:dirt_ordinary_with_turf_grove",
                "unilib:dirt_ordinary_with_turf",
            },
            y_max = 100,
            y_min = 1,
        })

    end

    if unilib.global.pkg_executed_table["biome_ethereal_frost"] ~= nil and
            unilib.global.pkg_executed_table["dirt_ordinary_with_turf_crystal"] ~= nil then

        unilib.register_decoration_complete("ethereal_fern_boston_2", nil, {
            -- From ethereal-ng/decor.lua
            biomes = "ethereal_frost_floatland",
            place_on = "unilib:dirt_ordinary_with_turf_crystal",
            y_max = 1750,
            y_min = 1025,
        })

    end

end
