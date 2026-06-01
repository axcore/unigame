---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    elysflowers
-- Code:    GPL-3.0-or-later
-- Media:   CC-BY-4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_elysflowers_flower_primrose_evening = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.elysflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_elysflowers_flower_primrose_evening.init()

    return {
        description = "Evening primrose as decoration",
        at_least_one = {
            {
                "biome_default_grassland",
                "biome_default_taiga",
                "biome_default_tundra",
                "biome_ethereal_grassland",
                "biome_ethereal_taiga",
                "biome_ethereal_tundra",
            },
            {
                "dirt_ordinary_with_litter_coniferous",
                "dirt_ordinary_with_turf",
            },
        },
    }

end

function unilib.pkg.deco_elysflowers_flower_primrose_evening.post()

    unilib.register_decoration_complete("elysflowers_flower_primrose_evening", nil, {
        -- From elysflowers/init.lua
        -- Completes decoration in package "flower_primrose_evening"
        biomes = {
            "default_grassland",
            "default_taiga",
            "default_tundra",
            "ethereal_grassland",
            "ethereal_taiga",
            "ethereal_tundra",
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
