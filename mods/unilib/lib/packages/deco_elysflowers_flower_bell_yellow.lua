---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    elysflowers
-- Code:    GPL-3.0-or-later
-- Media:   CC-BY-4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_elysflowers_flower_bell_yellow = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.elysflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_elysflowers_flower_bell_yellow.init()

    return {
        description = "Yellow bell as decoration",
        at_least_one = {
            {
                "biome_default_forest_coniferous",
                "biome_elysflowers_taiga_valley",
                "biome_ethereal_forest_coniferous",
            },
            {
                "dirt_ordinary_with_litter_coniferous",
                "dirt_ordinary_with_turf",
            },
        },
    }

end

function unilib.pkg.deco_elysflowers_flower_bell_yellow.post()

    unilib.register_decoration_complete("elysflowers_flower_bell_yellow", nil, {
        -- From elysflowers/init.lua
        -- Completes decoration in package "flower_bell_yellow"
        biomes = {
            "default_forest_coniferous",
            "elysflowers_taiga_valley",
            "ethereal_forest_coniferous",
        },
        num_spawn_by = -1,
        place_on = {
            "unilib:dirt_ordinary_with_litter_coniferous",
            "unilib:dirt_ordinary_with_turf",
        },
        -- (no spawn_by)
        y_max = unilib.constant.y_max,
        y_min = 1,
    })

end
