---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    elysflowers
-- Code:    GPL-3.0-or-later
-- Media:   CC-BY-4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_elysflowers_flower_coneflower_purple = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.elysflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_elysflowers_flower_coneflower_purple.init()

    return {
        description = "Purple coneflowers as decoration",
        at_least_one = {
            {
                "biome_default_grassland",
                "biome_default_forest_deciduous",
                "biome_ethereal_prairie",
                "biome_ethereal_grassy",
                "biome_ethereal_grassland",
                "biome_ethereal_forest_deciduous",
            },
            {
                "dirt_ordinary_with_turf",
                "dirt_ordinary_with_turf_prairie",
            },
        },
    }

end

function unilib.pkg.deco_elysflowers_flower_coneflower_purple.post()

    unilib.register_decoration_complete("elysflowers_flower_coneflower_purple_1", nil, {
        -- From elysflowers/init.lua
        -- Completes decoration in package "flower_coneflower_purple"
        biomes = {
            "default_forest_deciduous",
            "default_grassland",
            "ethereal_forest_deciduous",
            "ethereal_grassland",
            "ethereal_grassy",
            "ethereal_prairie",
        },
        num_spawn_by = -1,
        place_on = {"unilib:dirt_ordinary_with_turf", "unilib:dirt_ordinary_with_turf_prairie"},
        -- (no spawn_by)
        y_max = unilib.constant.y_max,
        y_min = 1,
    })
    unilib.register_decoration_complete("elysflowers_flower_coneflower_purple_2", nil, {
        -- From elysflowers/init.lua
        -- Completes decoration in package "flower_coneflower_purple"
        biomes = {
            "default_forest_deciduous",
            "default_grassland",
            "ethereal_forest_deciduous",
            "ethereal_grassland",
            "ethereal_grassy",
            "ethereal_prairie",
        },
        num_spawn_by = 1,
        place_on = {"unilib:dirt_ordinary_with_turf", "unilib:dirt_ordinary_with_turf_prairie"},
        spawn_by = "unilib:flower_coneflower_purple_1",
        y_max = unilib.constant.y_max,
        y_min = 1,
    })

end
