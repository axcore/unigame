---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_australia_grass_mitchell = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_australia_grass_mitchell.init()

    return {
        description = "Mitchell grass as decoration",
        depends = "grass_mitchell",
        optional = {
            "biome_australia_central_australia",
            "biome_australia_gulf_of_carpentaria",
            "biome_australia_pilbara",
            "dirt_ordinary",
            "dirt_red_antipodean",
            "gravel_red_antipodean",
        },
    }

end

function unilib.pkg.deco_australia_grass_mitchell.exec()

    if unilib.pkg_executed_table["biome_australia_central_australia"] ~= nil and
            unilib.pkg_executed_table["dirt_red_antipodean"] ~= nil then

        unilib.register_decoration_now("australia_grass_mitchell", "australia_grass_mitchell_1", {
            -- From australia:mitchell_grass
            biomes = "australia_central_australia",
            place_on = "unilib:dirt_red_antipodean",
            y_max = 180,
            y_min = 37,
        })

    end

    if unilib.pkg_executed_table["biome_australia_gulf_of_carpentaria"] ~= nil and
            unilib.pkg_executed_table["dirt_ordinary"] ~= nil then

        unilib.register_decoration_now("australia_grass_mitchell", "australia_grass_mitchell_2", {
            -- From australia:mitchell_grass
            biomes = "australia_gulf_of_carpentaria",
            place_on = "unilib:dirt_ordinary_with_turf_dry",
            y_max = 35,
            y_min = 12,
        })

    end

    if unilib.pkg_executed_table["biome_australia_pilbara"] ~= nil and
            unilib.pkg_executed_table["gravel_red_antipodean"] ~= nil then

        unilib.register_decoration_now("australia_grass_mitchell", "australia_grass_mitchell_3", {
            -- From australia:mitchell_grass
            biomes = "australia_pilbara",
            place_on = "unilib:gravel_red_antipodean",
            y_max = unilib.y_max,
            y_min = 6,
        })

    end

end
