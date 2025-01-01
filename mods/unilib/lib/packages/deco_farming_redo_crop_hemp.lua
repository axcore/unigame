---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_farming_redo_crop_hemp = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_farming_redo_crop_hemp.init()

    return {
        description = "Hemp as decoration",
        depends = "crop_hemp",
        at_least_one = {"dirt_ordinary", "dirt_ordinary_with_turf_prairie"},
    }

end

function unilib.pkg.deco_farming_redo_crop_hemp.post()

    unilib.register_decoration_complete("farming_redo_crop_hemp", nil, {
        -- From farming_redo/mapgen.lua
        -- Completes decoration in package "crop_hemp"
        num_spawn_by = 1,
        place_on = {
            "unilib:dirt_ordinary_with_litter_rainforest",
            "unilib:dirt_ordinary_with_turf",
            "unilib:dirt_ordinary_with_turf_prairie",
        },
        spawn_by = "group:tree",
        y_max = 45,
        y_min = 3,
    })

end
