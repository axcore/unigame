---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_cropocalypse_plant_cotton_tundra = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cropocalypse.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_cropocalypse_plant_cotton_tundra.init()

    return {
        description = "Tundra cotton plant as decoration",
        depends = "plant_cotton_tundra",
        at_least_one = {"biome_default_grassland", "biome_default_tundra"},
        optional = "dirt_permafrost_ordinary",
    }

end

function unilib.pkg.deco_cropocalypse_plant_cotton_tundra.post()

    unilib.register_decoration_complete("cropocalypse_plant_cotton_tundra", nil, {
        -- From cropocalypse/decorative_plants.lua
        -- Completes decoration in package "plant_cotton_tundra"
        biomes = {"default_grassland", "default_tundra"},
        place_on = {
            "group:sand",
            "group:soil",
            "unilib:dirt_permafrost_ordinary_with_moss",
            "unilib:dirt_permafrost_ordinary_with_litter_stone",
        },
        y_max = unilib.constant.y_max,
        y_min = 1,
    })

end
