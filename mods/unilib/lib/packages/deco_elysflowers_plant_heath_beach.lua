---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    elysflowers
-- Code:    GPL-3.0-or-later
-- Media:   CC-BY-4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_elysflowers_plant_heath_beach = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.elysflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_elysflowers_plant_heath_beach.init()

    return {
        description = "Beach heath as decoration",
        depends = "sand_ordinary",
        at_least_one = {
            "biome_default_forest_deciduous",
            "biome_default_grassland",
            "biome_ethereal_forest_deciduous",
            "biome_ethereal_grassland",
            "biome_ethereal_grove",
        },
    }

end

function unilib.pkg.deco_elysflowers_plant_heath_beach.post()

    unilib.register_decoration_complete("elysflowers_plant_heath_beach", nil, {
        -- From elysflowers/init.lua
        -- Completes decoration in package "plant_heath_beach"
        biomes = {
            "default_forest_deciduous_ocean",
            "default_forest_deciduous_shore",
            "default_grassland_ocean",
            "default_grassland_beach",
            "ethereal_forest_deciduous_ocean",
            "ethereal_grassland_ocean",
            "ethereal_grove",
        },
        num_spawn_by = -1,
        place_on = "unilib:sand_ordinary",
        -- (no spawn_by)
        y_max = unilib.constant.y_max,
        y_min = 1,
    })

end
