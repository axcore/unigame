---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_farming_redo_crop_hemp = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_farming_redo_crop_hemp.init()

    return {
        description = "Hemp as decoration",
        depends = {"crop_hemp", "dirt_ordinary"},
    }

end

function unilib.pkg.deco_farming_redo_crop_hemp.exec()

    unilib.register_decoration_now("farming_redo_crop_hemp", nil, {
        -- From farming_redo/mapgen.lua
        -- Completes decoration in package "crop_hemp"
        num_spawn_by = 1,
        place_on = {
            "unilib:dirt_ordinary_with_litter_rainforest",
            "unilib:dirt_ordinary_with_turf",
        },
        spawn_by = "group:tree",
        y_max = 45,
        y_min = 3,
    })

end
