---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    elysflowers
-- Code:    GPL-3.0-or-later
-- Media:   CC-BY-4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_elysflowers_flower_larkspur = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.elysflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_elysflowers_flower_larkspur.init()

    return {
        description = "Larkspur as decoration",
        depends = "dirt_ordinary_with_turf",
        at_least_one = {
            "biome_default_forest_coniferous",
            "biome_default_forest_deciduous",
            "biome_default_grassland",
            "biome_ethereal_forest_coniferous",
            "biome_ethereal_forest_deciduous",
            "biome_ethereal_grassy",
            "biome_ethereal_grassland",
        },
    }

end

function unilib.pkg.deco_elysflowers_flower_larkspur.post()

    unilib.register_decoration_complete("elysflowers_flower_larkspur", nil, {
        -- From elysflowers/init.lua
        -- Completes decoration in package "flower_larkspur"
        biomes = {
            "default_forest_coniferous",
            "default_forest_deciduous",
            "default_grassland",
            "ethereal_forest_coniferous",
            "ethereal_forest_deciduous",
            "ethereal_grassland",
            "ethereal_grassy",
        },
        num_spawn_by = -1,
        place_on = "unilib:dirt_ordinary_with_turf",
        -- (no spawn_by)
        y_max = unilib.constant.y_max,
        y_min = 1,
    })

end
