---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    better_farming
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_better_farming_crop_tomato_cherry = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.better_farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_better_farming_crop_tomato_cherry.init()

    return {
        description = "Cherry tomato as decoration",
        depends = {"biome_default_forest_deciduous", "crop_tomato_cherry", "dirt_ordinary"},
    }

end

function unilib.pkg.deco_better_farming_crop_tomato_cherry.post()

    unilib.register_decoration_now("better_farming_crop_tomato_cherry", nil, {
        -- From better_farming, tomatoes.lua
        -- Completes decoration in package "crop_tomato_cherry"
        biomes = "default_forest_deciduous",
        place_on = "unilib:dirt_ordinary_with_turf",
        y_max = unilib.y_max,
        y_min = 1,
    })

end
