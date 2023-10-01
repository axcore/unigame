---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_cropocalypse_flower_iris_sturdy = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cropocalypse.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_cropocalypse_flower_iris_sturdy.init()

    return {
        description = "Sturdy iris as decoration",
        depends = "flower_iris_sturdy",
        at_least_one = {"biome_default_forest_coniferous", "biome_default_forest_deciduous"},
    }

end

function unilib.pkg.deco_cropocalypse_flower_iris_sturdy.post()

    unilib.register_decoration_now("cropocalypse_flower_iris_sturdy", nil, {
        -- From cropocalypse/decorative_plants.lua
        -- Completes decoration in package "flower_iris_sturdy"
        biomes = {"default_forest_coniferous", "default_forest_deciduous"},
        place_on = {"group:sand", "group:soil"},
        y_max = unilib.y_max,
        y_min = 1,
    })

end
