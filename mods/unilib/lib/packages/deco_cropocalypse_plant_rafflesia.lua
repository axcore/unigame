---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_cropocalypse_plant_rafflesia = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cropocalypse.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_cropocalypse_plant_rafflesia.init()

    return {
        description = "Rafflesia as decoration",
        depends = {"biome_default_rainforest", "plant_rafflesia"},
    }

end

function unilib.pkg.deco_cropocalypse_plant_rafflesia.post()

    unilib.register_decoration_now("cropocalypse_plant_rafflesia", nil, {
        -- From cropocalypse/decorative_plants.lua
        -- Completes decoration in package "plant_rafflesia"
        biomes = "default_rainforest",
        place_on = {"group:sand", "group:soil"},
        y_max = unilib.y_max,
        y_min = 1,
    })

end
