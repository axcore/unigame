---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_ethereal_plant_shrub_snowy = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_ethereal_plant_shrub_snowy.init()

    return {
        description = "Snowy grass shrub as decoration",
        depends = {"biome_ethereal_grayness", "dirt_ordinary_with_turf_grey", "plant_shrub_snowy"},
    }

end

function unilib.pkg.deco_ethereal_plant_shrub_snowy.post()

    unilib.register_decoration_complete("ethereal_plant_shrub_snowy", nil, {
        -- From ethereal-ng/decor.lua
        -- Completes decoration in package "plant_shrub_snowy"
        biomes = "ethereal_grayness",
        place_on = "unilib:dirt_ordinary_with_turf_grey",
        y_max = 100,
        y_min = 1,
    })

end
