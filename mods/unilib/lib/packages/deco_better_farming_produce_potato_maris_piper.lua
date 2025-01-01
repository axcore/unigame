---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    better_farming
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_better_farming_produce_potato_maris_piper = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.better_farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_better_farming_produce_potato_maris_piper.init()

    return {
        description = "Maris piper potato as decoration",
        depends = {"dirt_ordinary", "produce_potato_maris_piper"},
        at_least_one = {"biome_default_forest_coniferous", "biome_default_rainforest"},
    }

end

function unilib.pkg.deco_better_farming_produce_potato_maris_piper.post()

    unilib.register_decoration_complete("better_farming_produce_potato_maris_piper", nil, {
        -- From better_farming, potatoes.lua
        -- Completes decoration in package "produce_potato_maris_piper"
        biomes = {"default_forest_coniferous", "default_rainforest"},
        place_on = {
            "unilib:dirt_ordinary_with_litter_coniferous",
            "unilib:dirt_ordinary_with_litter_rainforest",
        },
        y_max = unilib.constant.y_max,
        y_min = 1,
    })

end
