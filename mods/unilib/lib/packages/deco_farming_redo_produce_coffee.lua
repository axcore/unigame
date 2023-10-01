---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_farming_redo_produce_coffee = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_farming_redo_produce_coffee.init()

    return {
        description = "Coffee as decoration",
        depends = "produce_coffee",
        at_least_one = {"dirt_dry", "dirt_ordinary"},
    }

end

function unilib.pkg.deco_farming_redo_produce_coffee.exec()

    unilib.register_decoration_now("farming_redo_produce_coffee", nil, {
        -- From farming_redo/mapgen.lua
        -- Completes decoration in package "produce_coffee"
        place_on = {
            "unilib:dirt_dry_with_turf_dry",
            "unilib:dirt_ordinary_with_litter_rainforest",
            "unilib:dirt_ordinary_with_turf",
        },
        y_max = 45,
        y_min = 20,
    })

end
