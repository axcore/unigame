---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_cropocalypse_plant_skunk_cabbage = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cropocalypse.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_cropocalypse_plant_skunk_cabbage.init()

    return {
        description = "Skunk cabbage as decoration",
        depends = "plant_skunk_cabbage",
        at_least_one = {"biome_default_forest_deciduous", "biome_default_tundra"},
        optional = "dirt_permafrost_ordinary",
    }

end

function unilib.pkg.deco_cropocalypse_plant_skunk_cabbage.post()

    unilib.register_decoration_complete("cropocalypse_plant_skunk_cabbage", nil, {
        -- From cropocalypse/decorative_plants.lua
        -- Completes decoration in package "plant_skunk_cabbage"
        biomes = {"default_forest_deciduous", "default_tundra"},
        place_on = {
            "group:sand",
            "group:soil",
            "unilib:dirt_permafrost_ordinary_with_moss",
            "unilib:dirt_permafrost_ordinary_with_litter_stone",
        },
        y_max = unilib.constant.y_max,
        y_min = 1,
    })

end
