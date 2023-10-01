---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aqua_farming
-- Code:    GPL 3.0
-- Media:   CC-BY-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_aqua_farming_crop_undersea_cucumber = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aqua_farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_aqua_farming_crop_undersea_cucumber.init()

    return {
        description = "Sea cucumber (as decoration)",
        depends = "crop_undersea_cucumber",
        at_least_one = {
            {
                "biome_default_desert_cold",
                "biome_default_forest_coniferous",
                "biome_default_taiga",
                "biome_default_tundra",
            },
            {"sand_desert", "sand_ordinary", "sand_silver"},
        },
    }

end

function unilib.pkg.deco_aqua_farming_crop_undersea_cucumber.post()

    local biome_list = {
        "default_desert_cold_ocean",
        "default_forest_coniferous_ocean",
        "default_taiga_ocean",
        "default_tundra_ocean",
    }

    if unilib.pkg_executed_table["sand_ordinary"] ~= nil then

        unilib.register_decoration_now("aqua_farming_crop_sea_cucumber_1", nil, {
            -- From aqua_farming/mapgen_sea_cucumber.lua
            -- Completes decoration in package "crop_undersea_cucumber"
            biomes = biome_list,
            place_on = "unilib:sand_ordinary",
            y_max = -5,
            y_min = -40,
        })

    end

    if unilib.pkg_executed_table["sand_silver"] ~= nil then

        unilib.register_decoration_now("aqua_farming_crop_sea_cucumber_2", nil, {
            -- From aqua_farming/mapgen_sea_cucumber.lua
            -- Completes decoration in package "crop_undersea_cucumber"
            biomes = biome_list,
            place_on = "unilib:sand_silver",
            y_max = -5,
            y_min = -40,
        })

    end

    if unilib.pkg_executed_table["sand_desert"] ~= nil then

        unilib.register_decoration_now("aqua_farming_crop_sea_cucumber_3", nil, {
            -- From aqua_farming/mapgen_sea_cucumber.lua
            -- Completes decoration in package "crop_undersea_cucumber"
            biomes = biome_list,
            place_on = "unilib:sand_desert",
            y_max = -5,
            y_min = -40,
        })

    end

end
