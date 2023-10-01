---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_ethereal_plant_shrub_firethorn = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_ethereal_plant_shrub_firethorn.init()

    return {
        description = "Firethorn shrub as decoration",
        depends = {"biome_ethereal_glacier", "plant_shrub_firethorn", "snow_ordinary"},
    }

end

function unilib.pkg.deco_ethereal_plant_shrub_firethorn.post()

    unilib.register_decoration_now("ethereal_plant_shrub_firethorn", nil, {
        -- From ethereal-ng/decor.lua
        -- Completes decoration in package "plant_shrub_firethorn"
        biomes = "ethereal_glacier",
        place_on = "unilib:snow_ordinary_block",
        y_max = 30,
        y_min = 1,
    })

end
