---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_farming_redo_crop_sunflower_giant = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_farming_redo_crop_sunflower_giant.init()

    return {
        description = "Giant sunflower as decoration",
        depends = {"crop_sunflower_giant", "dirt_ordinary"},
    }

end

function unilib.pkg.deco_farming_redo_crop_sunflower_giant.exec()

    unilib.register_decoration_now("farming_redo_crop_sunflower_giant", nil, {
        -- From farming_redo/mapgen.lua
        -- Completes decoration in package "crop_sunflower_giant"
        place_on = "unilib:dirt_ordinary_with_turf",
        y_max = 40,
        y_min = 10,
    })

end
