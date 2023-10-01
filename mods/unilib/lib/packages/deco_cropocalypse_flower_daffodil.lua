---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_cropocalypse_flower_daffodil = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cropocalypse.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_cropocalypse_flower_daffodil.init()

    return {
        description = "Daffodil as decoration",
        depends = "flower_daffodil",
        at_least_one = {"biome_default_forest_deciduous", "biome_default_grassland"},
    }

end

function unilib.pkg.deco_cropocalypse_flower_daffodil.post()

    unilib.register_decoration_now("cropocalypse_flower_daffodil", nil, {
        -- From cropocalypse/decorative_plants.lua
        -- Completes decoration in package "flower_daffodil"
        biomes = {"default_forest_deciduous", "default_grassland"},
        place_on = {"group:sand", "group:soil"},
        y_max = unilib.y_max,
        y_min = 1,
    })

end
