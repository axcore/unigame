---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_cropocalypse_flower_lupin = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cropocalypse.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_cropocalypse_flower_lupin.init()

    return {
        description = "Lupin as decoration",
        depends = "flower_lupin",
        at_least_one = {"biome_default_forest_coniferous", "biome_default_grassland"},
    }

end

function unilib.pkg.deco_cropocalypse_flower_lupin.post()

    unilib.register_decoration_complete("cropocalypse_flower_lupin", nil, {
        -- From cropocalypse/decorative_plants.lua
        -- Completes decoration in package "flower_lupin"
        biomes = {"default_forest_coniferous", "default_grassland"},
        place_on = {"group:sand", "group:soil"},
        y_max = unilib.constant.y_max,
        y_min = 1,
    })

end
