---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_cropocalypse_plant_beach_pea = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cropocalypse.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_cropocalypse_plant_beach_pea.init()

    return {
        description = "Beach pea as decoration",
        depends = {"biome_default_forest_coniferous", "plant_beach_pea"},
    }

end

function unilib.pkg.deco_cropocalypse_plant_beach_pea.post()

    unilib.register_decoration_now("cropocalypse_plant_beach_pea", nil, {
        -- From cropocalypse/decorative_plants.lua
        -- Completes decoration in package "plant_beach_pea"
        biomes = "default_forest_coniferous",
        place_on = {"group:sand", "group:soil"},
        y_max = unilib.y_max,
        y_min = 1,
    })

end
