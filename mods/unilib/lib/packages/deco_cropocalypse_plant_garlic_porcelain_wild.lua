---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_cropocalypse_plant_garlic_porcelain_wild = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cropocalypse.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_cropocalypse_plant_garlic_porcelain_wild.init()

    return {
        description = "Wild porcelain garlic plant as decoration",
        depends = {
            "biome_default_forest_deciduous",
            "dirt_ordinary",
            "plant_garlic_porcelain_wild",
        },
    }

end

function unilib.pkg.deco_cropocalypse_plant_garlic_porcelain_wild.post()

    unilib.register_decoration_complete("cropocalypse_plant_garlic_porcelain_wild", nil, {
        -- From cropocalypse/plants.lua
        -- Completes decoration in package "plant_garlic_porcelain_wild"
        biomes = "default_forest_deciduous",
        place_on = "unilib:dirt_ordinary_with_turf",
        y_max = unilib.constant.y_max,
        y_min = 1,
    })

end
