---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_ethereal_grass_jungle = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_ethereal_grass_jungle.init()

    return {
        description = "Jungle grass as decoration",
        depends = {"dirt_ordinary", "grass_jungle"},
        optional = {
            "biome_ethereal_jumble",
            "biome_ethereal_rainforest",
            "biome_ethereal_swamp",
            "dirt_ordinary_with_turf_rainforest",
        },
    }

end

function unilib.pkg.deco_ethereal_grass_jungle.exec()

    if unilib.pkg_executed_table["biome_ethereal_rainforest"] ~= nil and
            unilib.pkg_executed_table["dirt_ordinary_with_turf_rainforest"] ~= nil then

        unilib.register_decoration("ethereal_grass_jungle_1", {
            -- From ethereal-ng/decor.lua
            deco_type = "simple",
            decoration = "unilib:grass_jungle",

            fill_ratio = 0.1,
            sidelen = 80,
        })

    end

    if unilib.pkg_executed_table["biome_ethereal_jumble"] ~= nil then

        unilib.register_decoration("ethereal_grass_jungle_2", {
            -- From ethereal-ng/decor.lua
            deco_type = "simple",
            decoration = "unilib:grass_jungle",

            fill_ratio = 0.15,
            sidelen = 80,
        })

    end

    if unilib.pkg_executed_table["biome_ethereal_swamp"] ~= nil then

        unilib.register_decoration("ethereal_grass_jungle_3", {
            -- From ethereal-ng/decor.lua
            deco_type = "simple",
            decoration = "unilib:grass_jungle",

            fill_ratio = 0.25,
            sidelen = 80,
        })

    end

end

function unilib.pkg.deco_ethereal_grass_jungle.post()

    if unilib.pkg_executed_table["biome_ethereal_rainforest"] ~= nil and
            unilib.pkg_executed_table["dirt_ordinary_with_turf_rainforest"] ~= nil then

        unilib.register_decoration_now("ethereal_grass_jungle_1", nil, {
            -- From ethereal-ng/decor.lua
            biomes = "ethereal_rainforest",
            place_on = {
                "unilib:dirt_ordinary_with_litter_rainforest",
                "unilib:dirt_ordinary_with_turf_rainforest",
            },
            y_max = 100,
            y_min = 1,
        })

    end

    if unilib.pkg_executed_table["biome_ethereal_jumble"] ~= nil then

        unilib.register_decoration_now("ethereal_grass_jungle_2", nil, {
            -- From ethereal-ng/decor.lua
            biomes = "ethereal_jumble",
            place_on = "unilib:dirt_ordinary_with_turf",
            y_max = 100,
            y_min = 1,
        })

    end

    if unilib.pkg_executed_table["biome_ethereal_swamp"] ~= nil then

        unilib.register_decoration_now("ethereal_grass_jungle_3", nil, {
            -- From ethereal-ng/decor.lua
            biomes = "ethereal_swamp",
            place_on = "unilib:dirt_ordinary_with_turf",
            y_max = 100,
            y_min = 1,
        })

    end

end
