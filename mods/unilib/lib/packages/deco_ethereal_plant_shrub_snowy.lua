---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_ethereal_plant_shrub_snowy = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_ethereal_plant_shrub_snowy.init()

    return {
        description = "Snowy grass shrub as decoration",
        depends = "plant_shrub_snowy",
        optional = {
            "biome_ethereal_forest_coniferous",
            "biome_ethereal_grayness",
            "dirt_ordinary",
            "dirt_ordinary_with_turf_cold",
            "dirt_ordinary_with_turf_grey",
        },
    }

end

function unilib.pkg.deco_ethereal_plant_shrub_snowy.post()

    if unilib.pkg_executed_table["biome_ethereal_grayness"] ~= nil and
            unilib.pkg_executed_table["dirt_ordinary_with_turf_grey"] ~= nil then

        unilib.register_decoration_now(
            -- From ethereal-ng/decor.lua
            -- Completes decoration in package "plant_shrub_snowy"
            "ethereal_plant_shrub_snowy",
            "ethereal_plant_shrub_snowy_1",
            {
                biomes = "ethereal_grayness",
                place_on = "unilib:dirt_ordinary_with_turf_grey",
                y_max = 100,
                y_min = 1,
            }
        )

    end

    if unilib.pkg_executed_table["biome_ethereal_forest_coniferous"] ~= nil and
            unilib.pkg_executed_table["dirt_ordinary_with_turf_cold"] ~= nil and
            unilib.pkg_executed_table["dir_ordinary"] ~= nil then

        unilib.register_decoration_now(
            -- From ethereal-ng/decor.lua
            -- Completes decoration in package "plant_shrub_snowy"
            "ethereal_plant_shrub_snowy",
            "ethereal_plant_shrub_snowy_2",
            {
                biomes = "ethereal_forest_coniferous",
                place_on = {
                    "unilib:dirt_ordinary_with_litter_coniferous",
                    "unilib:dirt_ordinary_with_turf_cold",
                },
                y_max = 100,
                y_min = 1,
            }
        )

    end

end
