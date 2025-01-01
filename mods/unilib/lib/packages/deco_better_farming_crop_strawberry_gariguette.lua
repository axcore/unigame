---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    better_farming
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_better_farming_crop_strawberry_gariguette = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.better_farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_better_farming_crop_strawberry_gariguette.init()

    return {
        description = "Gariguette strawberry as decoration",
        depends = {"biome_default_grassland", "crop_strawberry_gariguette", "dirt_ordinary"},
    }

end

function unilib.pkg.deco_better_farming_crop_strawberry_gariguette.post()

    unilib.register_decoration_complete("better_farming_crop_strawberry_gariguette", nil, {
        -- From better_farming, strawberry.lua
        -- Completes decoration in package "crop_strawberry_gariguette"
        biomes = "default_grassland",
        place_on = "unilib:dirt_ordinary_with_turf",
        y_max = unilib.constant.y_max,
        y_min = 1,
    })

end
