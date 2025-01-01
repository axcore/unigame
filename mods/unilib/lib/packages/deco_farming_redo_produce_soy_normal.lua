---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_farming_redo_produce_soy_normal = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_farming_redo_produce_soy_normal.init()

    return {
        description = "Normal soy as decoration",
        depends = "produce_soy_normal",
        at_least_one = {"dirt_dry", "dirt_ordinary", "dirt_ordinary_with_turf_prairie"},
    }

end

function unilib.pkg.deco_farming_redo_produce_soy_normal.post()

    unilib.register_decoration_complete("farming_redo_produce_soy_normal", nil, {
        -- From farming_redo/mapgen.lua
        -- Completes decoration in package "produce_soy_normal"
        place_on = {
            "unilib:dirt_dry_with_turf_dry",
            "unilib:dirt_ordinary_with_litter_rainforest",
            "unilib:dirt_ordinary_with_turf",
            "unilib:dirt_ordinary_with_turf_dry",
            "unilib:dirt_ordinary_with_turf_prairie",
        },
        y_max = 50,
        y_min = 20,
    })

end
