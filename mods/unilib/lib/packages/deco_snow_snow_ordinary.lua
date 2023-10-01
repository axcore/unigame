---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    snow
-- Code:    GPL 3.0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_snow_snow_ordinary = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.snow.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_snow_snow_ordinary.init()

    return {
        description = "Ordinary snow as decoration",
        depends = "snow_ordinary",
        optional = {
            "biome_snow_alpine",
            "biome_snow_forest",
            "biome_snow_lush",
            "biome_snow_normal",
        },
        at_least_one = {"dirt_ordinary", "stone_ordinary"},
    }

end

function unilib.pkg.deco_snow_snow_ordinary.exec()

    if unilib.pkg_executed_table["dirt_ordinary"] ~= nil then

        unilib.register_decoration("snow_snow_ordinary_1", {
            -- From snow/mapgen_v7.lua
            deco_type = "simple",
            decoration = "unilib:snow_ordinary",

            fill_ratio = 10,
            sidelen = 16,
        })

    end

    if unilib.pkg_executed_table["stone_ordinary"] ~= nil then

        unilib.register_decoration("snow_snow_ordinary_2", {
            -- From snow/mapgen_v7.lua
            deco_type = "simple",
            decoration = "unilib:snow_ordinary",

            fill_ratio = 10,
            sidelen = 16,
        })

    end

end

function unilib.pkg.deco_snow_snow_ordinary.post()

    if unilib.pkg_executed_table["dirt_ordinary"] ~= nil then

        unilib.register_decoration_now("snow_snow_ordinary_1", nil, {
            -- From snow/mapgen_v7.lua
            biomes = {"snow_forest", "snow_lush", "snow_normal"},
            place_on = "unilib:dirt_ordinary_with_cover_snow",
        })

    end

    if unilib.pkg_executed_table["stone_ordinary"] ~= nil then

        unilib.register_decoration_now("snow_snow_ordinary_2", nil, {
            -- From snow/mapgen_v7.lua
            biomes = "snow_alpine",
            place_on = "unilib:stone_ordinary",
        })

    end

end
