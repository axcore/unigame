---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_cropocalypse_plant_squirreltail = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cropocalypse.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_cropocalypse_plant_squirreltail.init()

    return {
        description = "Squirreltail as decoration",
        depends = "plant_squirreltail",
        at_least_one = {
            "biome_default_desert_cold",
            "biome_default_forest_deciduous",
            "biome_default_grassland",
            "biome_default_savanna",
            "biome_default_tundra",
        },
        optional = "dirt_permafrost",
    }

end

function unilib.pkg.deco_cropocalypse_plant_squirreltail.post()

    unilib.register_decoration_now("cropocalypse_plant_squirreltail", nil, {
        -- From cropocalypse/decorative_plants.lua
        -- Completes decoration in package "plant_squirreltail"
        biomes = {
            "default_desert_cold",
            "default_forest_deciduous",
            "default_grassland",
            "default_savanna",
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
