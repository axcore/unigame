---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aqua_farming
-- Code:    GPL 3.0
-- Media:   CC-BY-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_aqua_farming_crop_undersea_algae = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aqua_farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_aqua_farming_crop_undersea_algae.init()

    return {
        description = "Green algae (as decoration)",
        depends = "crop_undersea_algae",
        at_least_one = {
            {
                "biome_default_desert",
                "biome_default_rainforest",
                "biome_default_savanna",
            },
            {"gravel_ordinary", "sand_desert", "sand_ordinary", "sand_silver"},
        },
    }

end

function unilib.pkg.deco_aqua_farming_crop_undersea_algae.post()

    local biome_list = {
        "default_desert_ocean",
        "default_rainforest_ocean",
        "default_savanna_ocean",
    }

    if unilib.global.pkg_executed_table["sand_ordinary"] ~= nil then

        unilib.register_decoration_complete("aqua_farming_crop_sea_algae_1", nil, {
            -- From aqua_farming/mapgen_sea_alga.lua
            -- Completes decoration in package "crop_undersea_algae"
            biomes = biome_list,
            place_on = "unilib:sand_ordinary",
            y_max = -2,
            y_min = -70,
        })

    end

    if unilib.global.pkg_executed_table["dirt_ordinary"] ~= nil then

        unilib.register_decoration_complete("aqua_farming_crop_sea_algae_2", nil, {
            -- From aqua_farming/mapgen_sea_alga.lua
            -- Completes decoration in package "crop_undersea_algae"
            biomes = biome_list,
            place_on = "unilib:dirt_ordinary",
            y_max = -2,
            y_min = -70,
        })

    end

    if unilib.global.pkg_executed_table["sand_desert"] ~= nil then

        unilib.register_decoration_complete("aqua_farming_crop_sea_algae_3", nil, {
            -- From aqua_farming/mapgen_sea_alga.lua
            -- Completes decoration in package "crop_undersea_algae"
            biomes = biome_list,
            place_on = "unilib:sand_desert",
            y_max = -2,
            y_min = -70,
        })

    end

    if unilib.global.pkg_executed_table["sand_silver"] ~= nil then

        unilib.register_decoration_complete("aqua_farming_crop_sea_algae_4", nil, {
            -- From aqua_farming/mapgen_sea_alga.lua
            -- Completes decoration in package "crop_undersea_algae"
            biomes = biome_list,
            place_on = "unilib:sand_silver",
            y_max = -2,
            y_min = -70,
        })

    end

end
