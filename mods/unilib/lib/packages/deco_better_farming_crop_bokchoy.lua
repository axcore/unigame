---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    better_farming
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_better_farming_crop_bokchoy = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.better_farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_better_farming_crop_bokchoy.init()

    return {
        description = "Bokchoy as decoration",
        depends = {"crop_bokchoy", "dirt_ordinary"},
        at_least_one = {"biome_default_forest_deciduous", "biome_default_rainforest"},
    }

end

function unilib.pkg.deco_better_farming_crop_bokchoy.post()

    unilib.register_decoration_now("better_farming_crop_bokchoy", nil, {
        -- From better_farming, bokchoy.lua
        -- Completes decoration in package "crop_bokchoy"
        biomes = {"default_forest_deciduous", "default_rainforest"},
        place_on = {
            "unilib:dirt_ordinary_with_litter_rainforest",
            "unilib:dirt_ordinary_with_turf",
        },
        y_max = unilib.y_max,
        y_min = 1,
    })

end
