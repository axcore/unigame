---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_cropocalypse_plant_celery_wild = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cropocalypse.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_cropocalypse_plant_celery_wild.init()

    return {
        description = "Wild celery plant as decoration",
        depends = "plant_celery_wild",
        at_least_one = {"biome_default_forest_coniferous", "biome_default_forest_deciduous"},
    }

end

function unilib.pkg.deco_cropocalypse_plant_celery_wild.post()

    unilib.register_decoration_complete("cropocalypse_plant_celery_wild", nil, {
        -- From cropocalypse/decorative_plants.lua
        -- Completes decoration in package "plant_celery_wild"
        biomes = {"default_forest_coniferous", "default_forest_deciduous"},
        place_on = {"group:sand", "group:soil"},
        y_max = unilib.constant.y_max,
        y_min = 1,
    })

end
