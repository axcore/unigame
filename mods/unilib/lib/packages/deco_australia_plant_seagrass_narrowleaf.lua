---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_australia_plant_seagrass_narrowleaf = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_australia_plant_seagrass_narrowleaf.init()

    return {
        description = "Narrowleaf seagrass as decoration",
        depends = {"plant_seagrass_narrowleaf", "sand_ordinary"},
        at_least_one = {
            "biome_australia_great_barrier_reef",
            "biome_australia_indian_ocean",
            "biome_australia_timor_sea",
        },
    }

end

function unilib.pkg.deco_australia_plant_seagrass_narrowleaf.post()

    if unilib.global.pkg_executed_table["biome_australia_great_barrier_reef"] ~= nil then

        unilib.register_decoration_complete("australia_plant_seagrass_narrowleaf_1", nil, {
            -- From australia:sea_grass
            biomes = "australia_great_barrier_reef",
            place_on = "unilib:sand_ordinary",
            y_max = -2,
            y_min = -10,
        })

    end

    if unilib.global.pkg_executed_table["biome_australia_indian_ocean"] ~= nil then

        unilib.register_decoration_complete("australia_plant_seagrass_narrowleaf_2", nil, {
            -- From australia:sea_grass
            biomes = "australia_indian_ocean",
            place_on = "unilib:sand_ordinary",
            y_max = -2,
            y_min = -10,
        })

    end

    if unilib.global.pkg_executed_table["biome_australia_timor_sea"] ~= nil then

        unilib.register_decoration_complete("australia_plant_seagrass_narrowleaf_3", nil, {
            -- From australia:sea_grass
            biomes = "australia_timor_sea",
            place_on = "unilib:sand_ordinary",
            y_max = -2,
            y_min = -10,
        })

    end

end
