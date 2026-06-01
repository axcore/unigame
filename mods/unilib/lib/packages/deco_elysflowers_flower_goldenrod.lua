---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    elysflowers
-- Code:    GPL-3.0-or-later
-- Media:   CC-BY-4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_elysflowers_flower_goldenrod = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.elysflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_elysflowers_flower_goldenrod.init()

    return {
        description = "Goldenrod as decoration",
        at_least_one = {
            {
                "biome_default_grassland",
                "biome_ethereal_prairie",
                "biome_ethereal_grassland",
            },
            {
                "dirt_dry_with_turf_dry",
                "dirt_ordinary_with_turf",
                "dirt_ordinary_with_turf_dry",
                "dirt_ordinary_with_turf_prairie",
            },
        },
    }

end

function unilib.pkg.deco_elysflowers_flower_goldenrod.post()

    unilib.register_decoration_complete("elysflowers_flower_goldenrod", nil, {
        -- From elysflowers/init.lua
        -- Completes decoration in package "flower_goldenrod"
        biomes = {"default_grassland", "ethereal_grassland", "ethereal_prairie"},
        num_spawn_by = -1,
        place_on = {
            "unilib:dirt_dry_with_turf_dry",
            "unilib:dirt_ordinary_with_turf",
            "unilib:dirt_ordinary_with_turf_dry",
            "unilib:dirt_ordinary_with_turf_prairie",
        },
        -- (no spawn_by)
        y_max = unilib.constant.y_max,
        y_min = 1,
    })

end
