---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_farming_redo_produce_parsley_flatleaf = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_farming_redo_produce_parsley_flatleaf.init()

    return {
        description = "Flat leaf parsley as decoration",
        depends = "produce_parsley_flatleaf",
        at_least_one = {
            "dirt_ordinary",
            "dirt_ordinary_with_turf_grove",
            "dirt_ordinary_with_turf_prairie",
        },
    }

end

function unilib.pkg.deco_farming_redo_produce_parsley_flatleaf.post()

    unilib.register_decoration_complete("farming_redo_produce_parsley_flatleaf", nil, {
        -- From farming_redo/mapgen.lua
        -- Completes decoration in package "produce_parsley_flatleaf"
        place_on = {
            "unilib:dirt_ordinary_with_turf",
            "unilib:dirt_ordinary_with_turf_grove",
            "unilib:dirt_ordinary_with_turf_prairie",
        },
        y_max = 40,
        y_min = 10,
    })

end
