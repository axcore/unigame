---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_ethereal_produce_grape = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_ethereal_produce_grape.init()

    return {
        description = "Grapes as decoration",
        depends = "produce_grape",
        optional = {
            "biome_ethereal_forest_deciduous",
            "biome_ethereal_grassy",
            "biome_ethereal_prairie",
            "dirt_ordinary",
            "dirt_ordinary_with_turf_prairie",
        },
    }

end

function unilib.pkg.deco_ethereal_produce_grape.exec()

    unilib.register_decoration("ethereal_produce_grape", {
        -- From ethereal-ng/decor.lua
        deco_type = "simple",
        decoration = "unilib:produce_grape_wild",

        fill_ratio = 0.025,
        sidelen = 80,
    })

end

function unilib.pkg.deco_ethereal_produce_grape.post()

    if unilib.pkg_executed_table["biome_ethereal_grassy"] ~= nil and
            unilib.pkg_executed_table["dirt_ordinary"] ~= nil then

        unilib.register_decoration_now("ethereal_produce_grape", "ethereal_produce_grape_1", {
            -- From ethereal-ng/decor.lua
            biomes = "ethereal_grassy",
            place_on = "unilib:dirt_ordinary_with_turf",
            y_max = 100,
            y_min = 1,
        })

    end

    if unilib.pkg_executed_table["biome_ethereal_forest_deciduous"] ~= nil and
            unilib.pkg_executed_table["dirt_ordinary"] ~= nil then

        unilib.register_decoration_now("ethereal_produce_grape", "ethereal_produce_grape_2", {
            -- From ethereal-ng/decor.lua
            biomes = "ethereal_forest_deciduous",
            place_on = "unilib:dirt_ordinary_with_turf",
            y_max = 100,
            y_min = 1,
        })

    end

    if unilib.pkg_executed_table["biome_ethereal_prairie"] ~= nil and
            unilib.pkg_executed_table["dirt_ordinary_with_turf_prairie"] ~= nil then

        unilib.register_decoration_now("ethereal_produce_grape", "ethereal_produce_grape_3", {
            -- From ethereal-ng/decor.lua
            biomes = "ethereal_prairie",
            place_on = "unilib:dirt_ordinary_with_turf_prairie",
            y_max = 100,
            y_min = 1,
        })

    end

end
