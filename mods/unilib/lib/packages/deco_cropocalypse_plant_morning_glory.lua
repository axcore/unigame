---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_cropocalypse_plant_morning_glory = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cropocalypse.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_cropocalypse_plant_morning_glory.init()

    return {
        description = "Morning glory as decoration",
        depends = "plant_morning_glory",
        at_least_one = {"biome_default_forest_deciduous", "biome_default_rainforest"},
    }

end

function unilib.pkg.deco_cropocalypse_plant_morning_glory.post()

    unilib.register_decoration_complete("cropocalypse_plant_morning_glory", nil, {
        -- From cropocalypse/decorative_plants.lua
        -- Completes decoration in package "plant_morning_glory"
        biomes = {"default_forest_deciduous", "default_rainforest"},
        place_on = {"group:sand", "group:soil"},
        y_max = unilib.constant.y_max,
        y_min = 1,
    })

end
