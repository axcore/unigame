---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_cropocalypse_plant_bog_star = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cropocalypse.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_cropocalypse_plant_bog_star.init()

    return {
        description = "Bog star as decoration",
        depends = "plant_bog_star",
        at_least_one = {"biome_default_forest_deciduous", "biome_default_grassland"},
    }

end

function unilib.pkg.deco_cropocalypse_plant_bog_star.post()

    unilib.register_decoration_complete("cropocalypse_plant_bog_star", nil, {
        -- From cropocalypse/decorative_plants.lua
        -- Completes decoration in package "plant_bog_star"
        biomes = {"default_forest_deciduous", "default_grassland"},
        place_on = {"group:sand", "group:soil"},
        y_max = unilib.constant.y_max,
        y_min = 1,
    })

end
