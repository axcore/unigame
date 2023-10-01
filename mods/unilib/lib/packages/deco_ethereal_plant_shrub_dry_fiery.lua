---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_ethereal_plant_shrub_dry_fiery = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_ethereal_plant_shrub_dry_fiery.init()

    return {
        description = "Fiery dry shrub as decoration",
        depends = {
            "biome_ethereal_fiery",
            "dirt_ordinary_with_turf_fiery",
            "plant_shrub_dry_fiery",
        },
    }

end

function unilib.pkg.deco_ethereal_plant_shrub_dry_fiery.post()

    unilib.register_decoration_now("ethereal_plant_shrub_dry_fiery", nil, {
        -- From ethereal-ng/decor.lua
        -- Completes decoration in package "plant_shrub_dry_fiery"
        biomes = "ethereal_fiery",
        place_on = "unilib:dirt_ordinary_with_turf_fiery",
        y_max = 100,
        y_min = 1,
    })

end
