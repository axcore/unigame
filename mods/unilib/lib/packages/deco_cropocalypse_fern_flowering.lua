---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_cropocalypse_fern_flowering = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cropocalypse.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_cropocalypse_fern_flowering.init()

    return {
        description = "Flowering fern as decoration",
        depends = "fern_flowering",
        at_least_one = {
            "biome_default_forest_coniferous",
            "biome_default_forest_deciduous",
            "biome_default_grassland",
            "biome_default_rainforest",
            "biome_default_tundra",
        },
        optional = "dirt_permafrost",
    }

end

function unilib.pkg.deco_cropocalypse_fern_flowering.post()

    unilib.register_decoration_now("cropocalypse_fern_flowering", nil, {
        -- From cropocalypse/decorative_plants.lua
        -- Completes decoration in package "fern_flowering"
        biomes = {
            "default_forest_coniferous",
            "default_forest_deciduous",
            "default_grassland",
            "default_rainforest",
            "default_tundra",
        },
        place_on = {
            "group:sand",
            "group:soil",
            "unilib:dirt_permafrost_with_moss",
            "unilib:dirt_permafrost_with_stonelet",
        },
        y_max = unilib.y_max,
        y_min = 1,
    })

end
