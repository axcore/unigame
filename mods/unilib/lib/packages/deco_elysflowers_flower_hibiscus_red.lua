---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    elysflowers
-- Code:    GPL-3.0-or-later
-- Media:   CC-BY-4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_elysflowers_flower_hibiscus_red = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.elysflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_elysflowers_flower_hibiscus_red.init()

    return {
        description = "Red hibiscus as decoration",
        at_least_one = {
            {"biome_default_rainforest", "biome_ethereal_rainforest"},
            {"dirt_ordinary_with_litter_rainforest", "dirt_ordinary_with_turf"},
        },
    }

end

function unilib.pkg.deco_elysflowers_flower_hibiscus_red.post()

    unilib.register_decoration_complete("elysflowers_flower_hibiscus_red", nil, {
        -- From elysflowers/init.lua
        -- Completes decoration in package "flower_hibiscus_red"
        biomes = {
            "default_rainforest",
            "default_rainforest_ocean",
            "ethereal_rainforest",
            "ethereal_rainforest_ocean",
        },
        num_spawn_by = -1,
        place_on = {
            "unilib:dirt_ordinary_with_litter_rainforest",
            "unilib:dirt_ordinary_with_turf",
        },
        -- (no spawn_by)
        y_max = unilib.constant.y_max,
        y_min = 1,
    })

end
