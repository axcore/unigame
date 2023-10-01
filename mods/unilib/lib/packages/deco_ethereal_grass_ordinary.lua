---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_ethereal_grass_ordinary = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_ethereal_grass_ordinary.init()

    return {
        description = "Ordinary grass as decoration",
        depends = {"dirt_ordinary", "grass_ordinary"},
        optional = {
            "biome_ethereal_bamboo",
            "biome_ethereal_forest_deciduous",
            "biome_ethereal_grassy",
            "biome_ethereal_grove",
            "biome_ethereal_jumble",
            "biome_ethereal_mediterranean",
            "biome_ethereal_prairie",
            "biome_ethereal_rainforest",
            "biome_ethereal_sakura",
            "dirt_ordinary_with_turf_bamboo",
            "dirt_ordinary_with_turf_grove",
            "dirt_ordinary_with_turf_rainforest",
            "dirt_ordinary_with_turf_prairie",
        },
    }

end

function unilib.pkg.deco_ethereal_grass_ordinary.exec()

    unilib.register_decoration("ethereal_grass_ordinary", {
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

    if unilib.pkg_executed_table["biome_ethereal_grassland"] ~= nil and
            unilib.pkg_executed_table["biome_ethereal_swamp"] ~= nil then

        unilib.register_decoration("ethereal_grass_ordinary_9", {
            -- From ethereal-ng/decor.lua
            deco_type = "simple",
            decoration = {
                "unilib:grass_ordinary_3",
                "unilib:grass_ordinary_4",
            },

            fill_ratio = 0.35,
            sidelen = 80,
        })

    end

end

function unilib.pkg.deco_ethereal_grass_ordinary.post()

    if unilib.pkg_executed_table["biome_ethereal_forest_deciduous"] ~= nil then

        unilib.register_decoration_now("ethereal_grass_ordinary", "ethereal_grass_ordinary_1", {
            -- From ethereal-ng/decor.lua
            biomes = "ethereal_deciduous",
            place_on = "unilib:dirt_ordinary_with_turf",
            y_max = 100,
            y_min = 1,
        })

    end

    if unilib.pkg_executed_table["biome_ethereal_grassy"] ~= nil then

        unilib.register_decoration_now("ethereal_grass_ordinary", "ethereal_grass_ordinary_2", {
            -- From ethereal-ng/decor.lua
            biomes = "ethereal_grassy",
            place_on = "unilib:dirt_ordinary_with_turf",
            y_max = 100,
            y_min = 1,
        })

    end

    if unilib.pkg_executed_table["biome_ethereal_jumble"] ~= nil then

        unilib.register_decoration_now("ethereal_grass_ordinary", "ethereal_grass_ordinary_3", {
            -- From ethereal-ng/decor.lua
            biomes = "ethereal_jumble",
            place_on = "unilib:dirt_ordinary_with_turf",
            y_max = 100,
            y_min = 1,
        })

    end

    if unilib.pkg_executed_table["biome_ethereal_rainforest"] ~= nil and
            unilib.pkg_executed_table["dirt_ordinary_with_turf_rainforest"] ~= nil then

        unilib.register_decoration_now("ethereal_grass_ordinary", "ethereal_grass_ordinary_4", {
            -- From ethereal-ng/decor.lua
            biomes = "ethereal_rainforest",
            place_on = {
                "unilib:dirt_ordinary_with_turf_rainforest",
                "unilib:dirt_ordinary_with_litter_rainforest",
            },
            y_max = 100,
            y_min = 1,
        })

    end

    if unilib.pkg_executed_table["biome_ethereal_prairie"] ~= nil and
            unilib.pkg_executed_table["dirt_ordinary_with_turf_prairie"] ~= nil then

        unilib.register_decoration_now("ethereal_grass_ordinary", "ethereal_grass_ordinary_5", {
            -- From ethereal-ng/decor.lua
            biomes = "ethereal_prairie",
            place_on = "unilib:dirt_ordinary_with_turf_prairie",
            y_max = 100,
            y_min = 1,
        })

    end

    if unilib.pkg_executed_table["biome_ethereal_grove"] ~= nil and
            unilib.pkg_executed_table["dirt_ordinary_with_turf_grove"] ~= nil then

        unilib.register_decoration_now("ethereal_grass_ordinary", "ethereal_grass_ordinary_6", {
            -- From ethereal-ng/decor.lua
            biomes = "ethereal_grove",
            place_on = "unilib:dirt_ordinary_with_turf_grove",
            y_max = 100,
            y_min = 1,
        })

    end

    if unilib.pkg_executed_table["biome_ethereal_mediterranean"] ~= nil and
            unilib.pkg_executed_table["dirt_ordinary_with_turf_grove"] ~= nil then

        unilib.register_decoration_now("ethereal_grass_ordinary", "ethereal_grass_ordinary_7", {
            -- From ethereal-ng/decor.lua
            biomes = "ethereal_mediterranean",
            place_on = "unilib:dirt_ordinary_with_turf_grove",
            y_max = 100,
            y_min = 1,
        })

    end

    if unilib.pkg_executed_table["biome_ethereal_bamboo"] ~= nil and
            unilib.pkg_executed_table["dirt_ordinary_with_turf_bamboo"] ~= nil then

        unilib.register_decoration_now("ethereal_grass_ordinary", "ethereal_grass_ordinary_8", {
            -- From ethereal-ng/decor.lua
            biomes = "ethereal_bamboo",
            place_on = "unilib:dirt_ordinary_with_turf_bamboo",
            y_max = 100,
            y_min = 1,
        })

    end

    if unilib.pkg_executed_table["biome_ethereal_grassland"] ~= nil and
            unilib.pkg_executed_table["biome_ethereal_swamp"] ~= nil then

        unilib.register_decoration_now("ethereal_grass_ordinary_9", nil, {
            -- From ethereal-ng/decor.lua
            biomes = {"ethereal_grassland", "ethereal_swamp"},
            place_on = "unilib:dirt_ordinary_with_turf",
            y_max = 100,
            y_min = 1,
        })

    end

    if unilib.pkg_executed_table["biome_ethereal_sakura"] ~= nil and
            unilib.pkg_executed_table["dirt_ordinary_with_turf_bamboo"] ~= nil then

        unilib.register_decoration_now("ethereal_grass_ordinary", "ethereal_grass_ordinary_10", {
            -- From ethereal-ng/decor.lua
            biomes = "ethereal_sakura",
            place_on = "unilib:dirt_ordinary_with_turf_bamboo",
            y_max = 100,
            y_min = 1,
        })

    end

end
