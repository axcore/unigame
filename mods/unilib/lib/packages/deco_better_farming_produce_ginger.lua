---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    better_farming
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_better_farming_produce_ginger = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.better_farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_better_farming_produce_ginger.init()

    return {
        description = "Ginger as decoration",
        depends = {"dirt_ordinary", "produce_ginger"},
        at_least_one = {"biome_default_taiga", "biome_default_tundra"},
    }

end

function unilib.pkg.deco_better_farming_produce_ginger.post()

    unilib.register_decoration_complete("better_farming_produce_ginger", nil, {
        -- From better_farming, ginger.lua
        -- Completes decoration in package "produce_ginger"
        biomes = {"default_taiga", "default_tundra"},
        place_on = {
            "unilib:dirt_ordinary_with_litter_rainforest",
            "unilib:dirt_ordinary_with_cover_snow",
        },
        y_max = unilib.constant.y_max,
        y_min = 1,
    })

end
