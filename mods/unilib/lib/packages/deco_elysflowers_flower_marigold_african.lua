---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    elysflowers
-- Code:    GPL-3.0-or-later
-- Media:   CC-BY-4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_elysflowers_flower_marigold_african = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.elysflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_elysflowers_flower_marigold_african.init()

    return {
        description = "African marigold as decoration",
        at_least_one = {
            {
                "biome_default_savanna",
                "biome_ethereal_jumble",
                "biome_ethereal_mesa",
                "biome_ethereal_savanna",
            },
            {
                "dirt_ordinary_with_turf",
                "dirt_ordinary_with_turf_dry",
            },
        },
    }

end

function unilib.pkg.deco_elysflowers_flower_marigold_african.post()

    unilib.register_decoration_complete("elysflowers_flower_marigold_african", nil, {
        -- From elysflowers/init.lua
        -- Completes decoration in package "flower_marigold_african"
        biomes = {
            "default_savanna",
            "ethereal_jumble",
            "ethereal_mesa",
            "ethereal_mesa_redwood",
            "ethereal_savanna",
        },
        num_spawn_by = -1,
        place_on = {"unilib:dirt_ordinary_with_turf", "unilib:dirt_ordinary_with_turf_dry"},
        -- (no spawn_by)
        y_max = unilib.constant.y_max,
        y_min = 1,
    })

end
