---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_cropocalypse_plant_fireweed = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cropocalypse.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_cropocalypse_plant_fireweed.init()

    return {
        description = "Fireweed as decoration",
        depends = "plant_fireweed",
        at_least_one = {"biome_default_forest_coniferous", "biome_default_grassland"},
    }

end

function unilib.pkg.deco_cropocalypse_plant_fireweed.post()

    unilib.register_decoration_now("cropocalypse_plant_fireweed", nil, {
        -- From cropocalypse/decorative_plants.lua
        -- Completes decoration in package "plant_fireweed"
        biomes = {"default_forest_coniferous", "default_grassland"},
        place_on = {"group:sand", "group:soil"},
        y_max = unilib.y_max,
        y_min = 1,
    })

end
