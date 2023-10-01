---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_ethereal_produce_melon_pumpkin = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_ethereal_produce_melon_pumpkin.init()

    return {
        description = "Melons and pumpkins as decoration",
        depends = {"dirt_ordinary", "liquid_water_ordinary"},
        at_least_one = {
            {"produce_melon", "produce_pumpkin_yellow"},
            {
                "biome_ethereal_forest_deciduous",
                "biome_ethereal_grassy",
                "biome_ethereal_jumble",
                "biome_ethereal_rainforest",
                "dirt_ordinary_with_turf_rainforest",
            },
        },
    }

end

function unilib.pkg.deco_ethereal_produce_melon_pumpkin.exec()

    unilib.register_decoration("ethereal_produce_melon_pumpkin", {
        -- From ethereal-ng/decor.lua
        deco_type = "simple",
        decoration = {"unilib:produce_melon_grow_8", "unilib:produce_pumpkin_yellow_grow_8"},

        fill_ratio = 0.015,
        sidelen = 80,
    })

end

function unilib.pkg.deco_ethereal_produce_melon_pumpkin.post()

    if unilib.pkg_executed_table["biome_ethereal_rainforest"] ~= nil and
            unilib.pkg_executed_table["dirt_ordinary_with_turf_rainforest"] ~= nil then

        unilib.register_decoration_now(
            -- From ethereal-ng/decor.lua
            "ethereal_produce_melon_pumpkin",
            "ethereal_produce_melon_pumpkin_1",
            {
                biomes = "ethereal_rainforest",
                num_spawn_by = 1,
                place_on = {
                    "unilib:dirt_ordinary_with_litter_rainforest",
                    "unilib:dirt_ordinary_with_turf_rainforest",
                },
                spawn_by = "unilib:liquid_water_ordinary_source",
                y_max = 1,
                y_min = 1,
            }
        )

    end

    if unilib.pkg_executed_table["biome_ethereal_forest_deciduous"] ~= nil then

        unilib.register_decoration_now(
            -- From ethereal-ng/decor.lua
            "ethereal_produce_melon_pumpkin",
            "ethereal_produce_melon_pumpkin_2",
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

    if unilib.pkg_executed_table["biome_ethereal_grassy"] ~= nil then

        unilib.register_decoration_now(
            -- From ethereal-ng/decor.lua
            "ethereal_produce_melon_pumpkin",
            "ethereal_produce_melon_pumpkin_3",
            {
                biomes = "ethereal_grassy",
                num_spawn_by = 1,
                place_on = "unilib:dirt_ordinary_with_turf",
                spawn_by = "unilib:liquid_water_ordinary_source",
                y_max = 1,
                y_min = 1,
            }
        )

    end

    if unilib.pkg_executed_table["biome_ethereal_jumble"] ~= nil then

        unilib.register_decoration_now(
            -- From ethereal-ng/decor.lua
            "ethereal_produce_melon_pumpkin",
            "ethereal_produce_melon_pumpkin_4",
            {
                biomes = "ethereal_jumble",
                num_spawn_by = 1,
                place_on = "unilib:dirt_ordinary_with_turf",
                spawn_by = "unilib:liquid_water_ordinary_source",
                y_max = 1,
                y_min = 1,
            }
        )

    end

end
