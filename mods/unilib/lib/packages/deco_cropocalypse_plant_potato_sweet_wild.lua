---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_cropocalypse_plant_potato_sweet_wild = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cropocalypse.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_cropocalypse_plant_potato_sweet_wild.init()

    return {
        description = "Wild sweet potato plant as decoration",
        depends = {"biome_default_rainforest", "dirt_ordinary", "plant_potato_sweet_wild"},
    }

end

function unilib.pkg.deco_cropocalypse_plant_potato_sweet_wild.post()

    unilib.register_decoration_complete("cropocalypse_plant_potato_sweet_wild", nil, {
        -- From cropocalypse/plants.lua
        -- Completes decoration in package "plant_potato_sweet_wild"
        biomes = "default_rainforest",
        place_on = "unilib:dirt_ordinary_with_litter_rainforest",
        y_max = unilib.constant.y_max,
        y_min = 1,
    })

end
