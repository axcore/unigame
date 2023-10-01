---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aqua_farming
-- Code:    GPL 3.0
-- Media:   CC-BY-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_aqua_farming_crop_undersea_strawberry = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aqua_farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_aqua_farming_crop_undersea_strawberry.init()

    return {
        description = "Sea strawberry (as decoration)",
        depends = "crop_undersea_strawberry",
        at_least_one = {
            {
                "biome_default_desert",
                "biome_default_rainforest",
                "biome_default_savanna",
            },
            {"dirt_ordinary", "sand_desert", "sand_ordinary"},
        },
    }

end

function unilib.pkg.deco_aqua_farming_crop_undersea_strawberry.post()

    local biome_list = {
        "default_desert_ocean",
        "default_rainforest_ocean",
        "default_savanna_ocean",
    }

    if unilib.pkg_executed_table["sand_ordinary"] ~= nil then

        unilib.register_decoration_now("aqua_farming_crop_sea_strawberry_1", nil, {
            -- From aqua_farming/mapgen_sea_strawberry.lua
            -- Completes decoration in package "crop_undersea_strawberry"
            biomes = biome_list,
            place_on = "unilib:sand_ordinary",
            y_max = -2,
            y_min = -30,
        })

    end

    if unilib.pkg_executed_table["dirt_ordinary"] ~= nil then

        unilib.register_decoration_now("aqua_farming_crop_sea_strawberry_2", nil, {
            -- From aqua_farming/mapgen_sea_strawberry.lua
            -- Completes decoration in package "crop_undersea_strawberry"
            biomes = biome_list,
            place_on = "unilib:dirt_ordinary",
            y_max = -2,
            y_min = -30,
        })

    end

    if unilib.pkg_executed_table["sand_desert"] ~= nil then

        unilib.register_decoration_now("aqua_farming_crop_sea_strawberry_3", nil, {
            -- From aqua_farming/mapgen_sea_strawberry.lua
            -- Completes decoration in package "crop_undersea_strawberry"
            biomes = biome_list,
            place_on = "unilib:sand_desert",
            y_max = -2,
            y_min = -30,
        })

    end

end
