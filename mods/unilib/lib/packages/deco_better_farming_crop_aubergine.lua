---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    better_farming
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_better_farming_crop_aubergine = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.better_farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_better_farming_crop_aubergine.init()

    return {
        description = "Aubergine as decoration",
        depends = {"biome_default_forest_deciduous", "crop_aubergine", "dirt_ordinary"},
    }

end

function unilib.pkg.deco_better_farming_crop_aubergine.post()

    unilib.register_decoration_complete("better_farming_crop_aubergine", nil, {
        -- From better_farming, eggplants.lua
        -- Completes decoration in package "crop_aubergine"
        biomes = "default_forest_deciduous",
        place_on = "unilib:dirt_ordinary_with_turf",
        y_max = unilib.constant.y_max,
        y_min = 1,
    })

end
