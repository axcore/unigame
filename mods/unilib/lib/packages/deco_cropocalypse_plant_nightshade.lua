---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_cropocalypse_plant_nightshade = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cropocalypse.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_cropocalypse_plant_nightshade.init()

    return {
        description = "Nightshade plant as decoration",
        depends = "plant_nightshade",
        at_least_one = {"biome_default_forest_deciduous", "biome_default_rainforest"},
    }

end

function unilib.pkg.deco_cropocalypse_plant_nightshade.post()

    unilib.register_decoration_now("cropocalypse_plant_nightshade", nil, {
        -- From cropocalypse/decorative_plants.lua
        -- Completes decoration in package "plant_nightshade"
        biomes = {"default_forest_deciduous", "default_rainforest"},
        place_on = {"group:sand", "group:soil"},
        y_max = unilib.y_max,
        y_min = 1,
    })

end
