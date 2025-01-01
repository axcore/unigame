---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    better_farming
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_better_farming_crop_pepper_rocoto = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.better_farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_better_farming_crop_pepper_rocoto.init()

    return {
        description = "Rocoto pepper as decoration",
        depends = {"biome_default_grassland", "crop_pepper_rocoto", "dirt_ordinary"},
    }

end

function unilib.pkg.deco_better_farming_crop_pepper_rocoto.post()

    unilib.register_decoration_complete("better_farming_crop_pepper_rocoto", nil, {
        -- From better_farming, pepper.lua
        -- Completes decoration in package "crop_pepper_rocoto"
        biomes = "default_grassland",
        place_on = "unilib:dirt_ordinary_with_turf",
        y_max = unilib.constant.y_max,
        y_min = 1,
    })

end
