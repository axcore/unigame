---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_ethereal_snow_ordinary = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_ethereal_snow_ordinary.init()

    return {
        description = "Ordinary snow as decoration",
        depends = {"dirt_ordinary", "snow_ordinary"},
        optional = {
            "biome_ethereal_forest_coniferous",
            "biome_ethereal_taiga",
            "dirt_ordinary_with_turf_cold",
        },
    }

end

function unilib.pkg.deco_ethereal_snow_ordinary.exec()

    if unilib.pkg_executed_table["biome_ethereal_forest_coniferous"] ~= nil and
            unilib.pkg_executed_table["dirt_ordinary_with_turf_cold"] ~= nil then

        unilib.register_decoration("ethereal_snow_ordinary_1", {
            -- From ethereal-ng/decor.lua
            deco_type = "simple",
            decoration = "unilib:snow_ordinary",

            fill_ratio = 0.8,
            sidelen = 80,
        })

    end

    if unilib.pkg_executed_table["biome_ethereal_taiga"] ~= nil then

        unilib.register_decoration("ethereal_snow_ordinary_2", {
            -- From ethereal-ng/decor.lua
            deco_type = "simple",
            decoration = "unilib:snow_ordinary",

            fill_ratio = 0.8,
            sidelen = 80,
        })

    end

end

function unilib.pkg.deco_ethereal_snow_ordinary.post()

    if unilib.pkg_executed_table["biome_ethereal_forest_coniferous"] ~= nil and
            unilib.pkg_executed_table["dirt_ordinary_with_turf_cold"] ~= nil then

        unilib.register_decoration_now("ethereal_snow_ordinary_1", nil, {
            -- From ethereal-ng/decor.lua
            biomes = "ethereal_forest_coniferous",
            place_on = {
                "unilib:dirt_ordinary_with_litter_coniferous",
                "unilib:dirt_ordinary_with_turf_cold",
            },
            y_max = 40,
            y_min = 4,
        })

    end

    if unilib.pkg_executed_table["biome_ethereal_taiga"] ~= nil then

        unilib.register_decoration_now("ethereal_snow_ordinary_2", nil, {
            -- From ethereal-ng/decor.lua
            biomes = "ethereal_taiga",
            place_on = "unilib:dirt_ordinary_with_cover_snow",
            y_max = 140,
            y_min = 40,
        })

    end

end

