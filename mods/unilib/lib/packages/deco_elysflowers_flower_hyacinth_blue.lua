---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    elysflowers
-- Code:    GPL-3.0-or-later
-- Media:   CC-BY-4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_elysflowers_flower_hyacinth_blue = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.elysflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_elysflowers_flower_hyacinth_blue.init()

    return {
        description = "Blue hyacinth as decoration",
        at_least_one = {
            {
                "biome_default_forest_coniferous",
                "biome_default_grassland",
                "biome_default_taiga",
                "biome_ethereal_forest_coniferous",
                "biome_ethereal_grassland",
                "biome_ethereal_taiga",
            },
            {
                "dirt_ordinary_with_turf",
                "dirt_ordinary_with_turf_cold",
            },
        },
    }

end

function unilib.pkg.deco_elysflowers_flower_hyacinth_blue.post()

    unilib.register_decoration_complete("elysflowers_flower_hyacinth_blue", nil, {
        -- From elysflowers/init.lua
        -- Completes decoration in package "flower_hyacinth_blue"
        biomes = {
            "default_forest_coniferous",
            "default_grassland",
            "default_taiga",
            "ethereal_grassland",
            "ethereal_forest_coniferous",
            "ethereal_taiga",
        },
        num_spawn_by = -1,
        place_on = {"unilib:dirt_ordinary_with_turf", "unilib:dirt_ordinary_with_turf_cold"},
        -- (no spawn_by)
        y_max = unilib.constant.y_max,
        y_min = 1,
    })

end
