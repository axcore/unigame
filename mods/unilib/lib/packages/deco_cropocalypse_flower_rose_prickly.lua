---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_cropocalypse_flower_rose_prickly = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cropocalypse.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_cropocalypse_flower_rose_prickly.init()

    return {
        description = "Prickly rose as decoration",
        depends = "flower_rose_prickly",
        at_least_one = {"biome_default_forest_coniferous", "biome_default_taiga"},
    }

end

function unilib.pkg.deco_cropocalypse_flower_rose_prickly.post()

    unilib.register_decoration_now("cropocalypse_flower_rose_prickly", nil, {
        -- From cropocalypse/decorative_plants.lua
        -- Completes decoration in package "flower_rose_prickly"
        biomes = {"default_forest_coniferous", "default_taiga"},
        place_on = {"group:sand", "group:soil"},
        y_max = unilib.y_max,
        y_min = 1,
    })

end
