---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    better_farming
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_better_farming_crop_cabbage_brunswick = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.better_farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_better_farming_crop_cabbage_brunswick.init()

    return {
        description = "Brunswick cabbage as decoration",
        depends = {"biome_default_forest_deciduous", "crop_cabbage_brunswick", "dirt_ordinary"},
    }

end

function unilib.pkg.deco_better_farming_crop_cabbage_brunswick.post()

    unilib.register_decoration_now("better_farming_crop_cabbage_brunswick", nil, {
        -- From better_farming, cabbage.lua
        -- Completes decoration in package "crop_cabbage_brunswick"
        biomes = "default_forest_deciduous",
        place_on = "unilib:dirt_ordinary_with_turf",
        y_max = unilib.y_max,
        y_min = 1,
    })

end
