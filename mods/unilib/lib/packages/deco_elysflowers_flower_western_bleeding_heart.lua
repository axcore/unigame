---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    elysflowers
-- Code:    GPL-3.0-or-later
-- Media:   CC-BY-4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_elysflowers_flower_western_bleeding_heart = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.elysflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_elysflowers_flower_western_bleeding_heart.init()

    return {
        description = "Western bleeding-heart as decoration",
        depends = "dirt_ordinary_with_turf",
        at_least_one = {
            "biome_default_rainforest",
            "biome_ethereal_swamp",
            "biome_ethereal_rainforest",
        },
    }

end

function unilib.pkg.deco_elysflowers_flower_western_bleeding_heart.post()

    unilib.register_decoration_complete("elysflowers_flower_western_bleeding_heart", nil, {
        -- From elysflowers/init.lua
        -- Completes decoration in package "flower_western_bleeding_heart"
        biomes = {
            "default_rainforest",
            "default_rainforest_swamp",
            "ethereal_rainforest",
            "ethereal_swamp",
        },
        num_spawn_by = -1,
        place_on = "unilib:dirt_ordinary_with_turf",
        -- (no spawn_by)
        y_max = unilib.constant.y_max,
        y_min = 1,
    })

end
