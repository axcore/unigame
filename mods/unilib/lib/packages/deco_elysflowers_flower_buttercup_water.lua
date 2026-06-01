---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    elysflowers
-- Code:    GPL-3.0-or-later
-- Media:   CC-BY-4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_elysflowers_flower_buttercup_water = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.elysflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_elysflowers_flower_buttercup_water.init()

    return {
        description = "Water buttercup as decoration",
        depends = "liquid_water_ordinary",
        at_least_one = {
            "biome_default_forest_deciduous",
            "biome_ethereal_bamboo",
            "biome_ethereal_forest_deciduous",
            "biome_ethereal_grassy",
        },
    }

end

function unilib.pkg.deco_elysflowers_flower_buttercup_water.post()

    unilib.register_decoration_complete("elysflowers_flower_buttercup_water", nil, {
        -- From elysflowers/init.lua
        -- Completes decoration in package "flower_buttercup_water"
        biomes = {
            "default_forest_deciduous",
            "ethereal_bamboo",
            "ethereal_forest_deciduous",
            "ethereal_grassy",
        },
        num_spawn_by = -1,
        place_on = "unilib:liquid_water_ordinary_source",
        -- (no spawn_by)
        -- (no y_max, y_min)
    })

end
