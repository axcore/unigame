---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_ethereal_grass_dry = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_ethereal_grass_dry.init()

    return {
        description = "Dry grass as decoration",
        notes = "Also places dry shrubs in \"ethereal_caves\" biomes",
        depends = "grass_dry",
        depends = {
            "biome_ethereal_caves",
            "biome_ethereal_mesa",
            "biome_ethereal_savanna",
            "dirt_dry",
            "dirt_ordinary",
            "plant_shrub_dry",
            "stone_desert",
        },
    }

end

function unilib.pkg.deco_ethereal_grass_dry.exec()

    if unilib.global.pkg_executed_table["biome_ethereal_savanna"] ~= nil and
            unilib.global.pkg_executed_table["dirt_dry"] ~= nil and
            unilib.global.pkg_executed_table["dirt_ordinary"] ~= nil then

        unilib.register_decoration_generic("ethereal_grass_dry_1", {
            -- From ethereal-ng/decor.lua
            deco_type = "simple",
            decoration = {
                "unilib:grass_dry_2",
                "unilib:grass_dry_3",
                "unilib:grass_dry_4",
                "unilib:grass_dry_5",
            },

            fill_ratio = 0.25,
            sidelen = 80,
        })

    end

    if unilib.global.pkg_executed_table["biome_ethereal_mesa"] ~= nil and
            unilib.global.pkg_executed_table["dirt_ordinary"] ~= nil then

        unilib.register_decoration_generic("ethereal_grass_dry_2", {
            -- From ethereal-ng/decor.lua
            deco_type = "simple",
            decoration = {
                "unilib:grass_dry_2",
                "unilib:grass_dry_3",
                "unilib:grass_dry_4",
                "unilib:grass_dry_5",
            },

            fill_ratio = 0.1,
            sidelen = 80,
        })

    end

    if unilib.global.pkg_executed_table["biome_ethereal_caves"] ~= nil and
            unilib.global.pkg_executed_table["plant_shrub_dry"] ~= nil and
            unilib.global.pkg_executed_table["stone_desert"] ~= nil then

        unilib.register_decoration_generic("ethereal_grass_dry_3", {
            -- From ethereal-ng/decor.lua
            deco_type = "simple",
            decoration = {
                "unilib:grass_dry_2",
                "unilib:grass_dry_3",
                "unilib:plant_shrub_dry",
            },

            fill_ratio = 0.005,
            sidelen = 80,
        })

    end

end

function unilib.pkg.deco_ethereal_grass_dry.post()

    if unilib.global.pkg_executed_table["biome_ethereal_savanna"] ~= nil and
            unilib.global.pkg_executed_table["dirt_dry"] ~= nil and
            unilib.global.pkg_executed_table["dirt_ordinary"] ~= nil then

        unilib.register_decoration_complete("ethereal_grass_dry_1", nil, {
            -- From ethereal-ng/decor.lua
            biomes = "ethereal_savanna",
            place_on = {"unilib:dirt_dry_with_turf_dry", "unilib:dirt_ordinary_with_turf_dry"},
            y_max = 100,
            y_min = 1,
        })

    end

    if unilib.global.pkg_executed_table["biome_ethereal_mesa"] ~= nil and
            unilib.global.pkg_executed_table["dirt_ordinary"] ~= nil then

        unilib.register_decoration_complete("ethereal_grass_dry_2", nil, {
            -- From ethereal-ng/decor.lua
            biomes = "ethereal_mesa_redwood",
            place_on = "unilib:dirt_ordinary_with_turf_dry",
            y_max = 100,
            y_min = 1,
        })

    end

    if unilib.global.pkg_executed_table["biome_ethereal_caves"] ~= nil and
            unilib.global.pkg_executed_table["plant_shrub_dry"] ~= nil and
            unilib.global.pkg_executed_table["stone_desert"] ~= nil then

        unilib.register_decoration_complete("ethereal_grass_dry_3", nil, {
            -- From ethereal-ng/decor.lua
            biomes = "ethereal_caves",
            place_on = "unilib:stone_desert",
            y_max = 42,
            y_min = 5,
        })

    end

end
