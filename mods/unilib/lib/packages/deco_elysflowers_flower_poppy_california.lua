---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    elysflowers
-- Code:    GPL-3.0-or-later
-- Media:   CC-BY-4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_elysflowers_flower_poppy_california = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.elysflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_elysflowers_flower_poppy_california.init()

    return {
        description = "California poppy as decoration",
        at_least_one = {
            {
                "biome_default_savanna",
                "biome_ethereal_savanna",
                "biome_ethereal_mesa",
            },
            {
                "dirt_dried",
                "dirt_dry",
                "dirt_dry_with_turf_dry",
                "dirt_ordinary_with_turf",
            },
        },
    }

end

function unilib.pkg.deco_elysflowers_flower_poppy_california.post()

    unilib.register_decoration_complete("elysflowers_flower_poppy_california", nil, {
        -- From elysflowers/init.lua
        -- Completes decoration in package "flower_poppy_california"
        biomes = {"default_savanna", "ethereal_mesa", "ethereal_savanna"},
        num_spawn_by = -1,
        place_on = {
            "unilib:dirt_dried",
            "unilib:dirt_dry",
            "unilib:dirt_dry_with_turf_dry",
            "unilib:dirt_ordinary_with_turf",
        },
        -- (no spawn_by)
        y_max = 100,
        y_min = 25,
    })

end
