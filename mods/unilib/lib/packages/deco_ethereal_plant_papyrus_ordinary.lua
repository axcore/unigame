---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_ethereal_plant_papyrus_ordinary = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_ethereal_plant_papyrus_ordinary.init()

    return {
        description = "Ordinary papyrus as decoration",
        depends = {"dirt_ordinary", "liquid_water_ordinary", "plant_papyrus_ordinary"},
        optional = {
            "biome_ethereal_forest_deciduous",
            "biome_ethereal_rainforest",
            "biome_ethereal_swamp",
            "dirt_ordinary_with_turf_rainforest",
        },
    }

end

function unilib.pkg.deco_ethereal_plant_papyrus_ordinary.exec()

    unilib.register_decoration("ethereal_plant_papyrus_ordinary", {
        -- From ethereal-ng/decor.lua
        deco_type = "simple",
        decoration = "unilib:plant_papyrus_ordinary",

        fill_ratio = 0.1,
        height_max = 4,
        sidelen = 80,
    })

end

function unilib.pkg.deco_ethereal_plant_papyrus_ordinary.post()

    if unilib.pkg_executed_table["biome_ethereal_forest_deciduous"] ~= nil then

        unilib.register_decoration_now(
            -- From ethereal-ng/decor.lua
            "ethereal_plant_papyrus_ordinary",
            "ethereal_plant_papyrus_ordinary_1",
            {
                biomes = "ethereal_forest_deciduous",
                num_spawn_by = 1,
                place_on = "unilib:dirt_ordinary_with_turf",
                spawn_by = "unilib:liquid_water_ordinary_source",
                y_max = 1,
                y_min = 1,
            }
        )

    end

    if unilib.pkg_executed_table["biome_ethereal_rainforest"] ~= nil and
            unilib.pkg_executed_table["dirt_ordinary_with_turf_rainforest"] ~= nil then

        unilib.register_decoration_now(
            -- From ethereal-ng/decor.lua
            "ethereal_plant_papyrus_ordinary",
            "ethereal_plant_papyrus_ordinary_2",
            {
                biomes = "ethereal_rainforest",
                num_spawn_by = 1,
                place_on = {
                    "unilib:dirt_ordinary_with_turf_rainforest",
                    "unilib:dirt_ordinary_with_litter_rainforest",
                },
                spawn_by = "unilib:liquid_water_ordinary_source",
                y_max = 1,
                y_min = 1,
            }
        )

    end

    if unilib.pkg_executed_table["biome_ethereal_swamp"] ~= nil then

        unilib.register_decoration_now(
            -- From ethereal-ng/decor.lua
            "ethereal_plant_papyrus_ordinary",
            "ethereal_plant_papyrus_ordinary_3",
            {
                biomes = "ethereal_swamp",
                num_spawn_by = 1,
                place_on = "unilib:dirt_ordinary_with_turf",
                spawn_by = "unilib:liquid_water_ordinary_source",
                y_max = 1,
                y_min = 1,
            }
        )

    end

end

