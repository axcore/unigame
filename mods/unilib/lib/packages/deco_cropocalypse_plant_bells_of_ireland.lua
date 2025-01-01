---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_cropocalypse_plant_bells_of_ireland = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cropocalypse.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_cropocalypse_plant_bells_of_ireland.init()

    return {
        description = "Bells of Ireland as decoration",
        depends = {"biome_default_forest_deciduous", "plant_bells_of_ireland"},
    }

end

function unilib.pkg.deco_cropocalypse_plant_bells_of_ireland.post()

    unilib.register_decoration_complete("cropocalypse_plant_bells_of_ireland", nil, {
        -- From cropocalypse/decorative_plants.lua
        -- Completes decoration in package "plant_bells_of_ireland"
        biomes = "default_forest_deciduous",
        place_on = {"group:sand", "group:soil"},
        y_max = unilib.constant.y_max,
        y_min = 1,
    })

end
