---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_cropocalypse_plant_wheat_wild = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cropocalypse.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_cropocalypse_plant_wheat_wild.init()

    return {
        description = "Wild wheat plant as decoration",
        depends = "plant_wheat_wild",
        at_least_one = {
            "biome_default_desert",
            "biome_default_desert_cold",
            "biome_default_desert_sandstone",
            "biome_default_grassland",
            "biome_default_savanna",
        },
    }

end

function unilib.pkg.deco_cropocalypse_plant_wheat_wild.post()

    unilib.register_decoration_now("cropocalypse_plant_wheat_wild", nil, {
        -- From cropocalypse/decorative_plants.lua
        -- Completes decoration in package "plant_wheat_wild"
        biomes = {
            "default_desert",
            "default_desert_cold",
            "default_desert_sandstone",
            "default_grassland",
            "default_savanna",
        },
        place_on = {"group:sand", "group:soil"},
        y_max = unilib.y_max,
        y_min = 1,
    })

end
