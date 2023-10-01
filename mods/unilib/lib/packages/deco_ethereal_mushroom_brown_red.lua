---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_ethereal_mushroom_brown_red = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_ethereal_mushroom_brown_red.init()

    return {
        description = "Brown and red mushrooms as decoration",
        depends = {"dirt_ordinary", "mushroom_brown", "mushroom_red"},
        optional = {
            "biome_ethereal_forest_deciduous",
            "biome_ethereal_grassy",
            "biome_ethereal_mushroom",
            "biome_ethereal_prairie",
            "biome_ethereal_rainforest",
            "biome_ethereal_swamp",
            "dirt_ordinary_with_turf_mushroom",
            "dirt_ordinary_with_turf_prairie",
            "dirt_ordinary_with_turf_rainforest",
        },
    }

end

function unilib.pkg.deco_ethereal_mushroom_brown_red.exec()

    unilib.register_decoration("ethereal_mushroom_brown_red", {
        -- From ethereal-ng/decor.lua
        deco_type = "simple",
        decoration = {"unilib:mushroom_brown", "unilib:mushroom_red"},

        noise_params = {
            octaves = 3,
            offset = 0,
            persist = 0.66,
            scale = 0.009,
            seed = 2,
            spread = {x = 200, y = 200, z = 200},
        },
        sidelen = 16,
    })

end

function unilib.pkg.deco_ethereal_mushroom_brown_red.post()

    if unilib.pkg_executed_table["biome_ethereal_rainforest"] ~= nil and
            unilib.pkg_executed_table["dirt_ordinary_with_turf_rainforest"] ~= nil then

        unilib.register_decoration_now(
            -- From ethereal-ng/decor.lua
            "ethereal_mushroom_brown_red",
            "ethereal_mushroom_brown_red_1",
            {
                biomes = "ethereal_rainforest",
                place_on = {
                    "unilib:dirt_ordinary_with_litter_rainforest",
                    "unilib:dirt_ordinary_with_turf_rainforest",
                },
                y_max = 120,
                y_min = 1,
            }
        )

    end

    if unilib.pkg_executed_table["biome_ethereal_forest_deciduous"] ~= nil then

        unilib.register_decoration_now(
            -- From ethereal-ng/decor.lua
            "ethereal_mushroom_brown_red",
            "ethereal_mushroom_brown_red_2",
            {
                biomes = "ethereal_forest_deciduous",
                place_on = "unilib:dirt_ordinary_with_turf",
                y_max = 120,
                y_min = 1,
            }
        )

    end

    if unilib.pkg_executed_table["biome_ethereal_grassy"] ~= nil then

        unilib.register_decoration_now(
            -- From ethereal-ng/decor.lua
            "ethereal_mushroom_brown_red",
            "ethereal_mushroom_brown_red_3",
            {
                biomes = "ethereal_grassy",
                place_on = "unilib:dirt_ordinary_with_turf",
                y_max = 120,
                y_min = 1,
            }
        )

    end

    if unilib.pkg_executed_table["biome_ethereal_prairie"] ~= nil and
            unilib.pkg_executed_table["dirt_ordinary_with_turf_prairie"] ~= nil then

        unilib.register_decoration_now(
            -- From ethereal-ng/decor.lua
            "ethereal_mushroom_brown_red",
            "ethereal_mushroom_brown_red_4",
            {
                biomes = "ethereal_prairie",
                place_on = "unilib:dirt_ordinary_with_turf_prairie",
                y_max = 120,
                y_min = 1,
            }
        )

    end

    if unilib.pkg_executed_table["biome_ethereal_mushroom"] ~= nil and
            unilib.pkg_executed_table["dirt_ordinary_with_turf_mushroom"] ~= nil then

        unilib.register_decoration_now(
            -- From ethereal-ng/decor.lua
            "ethereal_mushroom_brown_red",
            "ethereal_mushroom_brown_red_5",
            {
                biomes = "ethereal_mushroom",
                place_on = "unilib:dirt_ordinary_with_turf_mushroom",
                y_max = 120,
                y_min = 1,
            }
        )

    end

    if unilib.pkg_executed_table["biome_ethereal_swamp"] ~= nil then

        unilib.register_decoration_now(
            -- From ethereal-ng/decor.lua
            "ethereal_mushroom_brown_red",
            "ethereal_mushroom_brown_red_6",
            {
                biomes = "ethereal_swamp",
                place_on = "unilib:dirt_ordinary_with_turf",
                y_max = 120,
                y_min = 1,
            }
        )

    end

end

