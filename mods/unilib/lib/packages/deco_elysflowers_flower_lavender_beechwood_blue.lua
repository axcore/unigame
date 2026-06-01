---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    elysflowers
-- Code:    GPL-3.0-or-later
-- Media:   CC-BY-4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_elysflowers_flower_lavender_beechwood_blue = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.elysflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_elysflowers_flower_lavender_beechwood_blue.init()

    return {
        description = "Beechwood blue lavender as decoration",
        at_least_one = {
            {
                "biome_ethereal_bamboo",
                "biome_ethereal_grassy",
            },
            {
                "dirt_ordinary_with_turf",
                "dirt_ordinary_with_turf_bamboo",
                "dirt_ordinary_with_turf_grove",
            },
        },
    }

end

function unilib.pkg.deco_elysflowers_flower_lavender_beechwood_blue.post()

    unilib.register_decoration_complete("elysflowers_flower_lavender_beechwood_blue", nil, {
        -- From elysflowers/init.lua
        -- Completes decoration in package "flower_lavender_beechwood_blue"
        biomes = {"ethereal_bamboo", "ethereal_grassy"},
        num_spawn_by = -1,
        place_on = {
            "unilib:dirt_ordinary_with_turf",
            "unilib:dirt_ordinary_with_turf_bamboo",
            "unilib:dirt_ordinary_with_turf_grove",
        },
        -- (no spawn_by)
        y_max = unilib.constant.y_max,
        y_min = 1,
    })

end
